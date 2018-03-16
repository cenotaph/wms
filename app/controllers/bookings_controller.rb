class BookingsController < ApplicationController
  before_action :authenticate_user!
  
  def accept
    @booking = Booking.find(params[:id])
    if current_user.has_role?(:admin) || current_user == @booking.teacher
      @booking.teacher_approved = true
      if @booking.save
        BookingsMailer.confirmed_booking(@booking).deliver_now
        flash[:notice] = 'You have accepted this booking. The student will receive an email and must pay the fee.'
      else
        flash[:error] = 'There was an error accepting this booking: ' + @booking.errors.messages.join(',')
      end
    end
    redirect_to '/'
  end
  
  def by_day
    @booking = Booking.find(params[:id])
    @user = @booking.teacher
    @times = Regularavailability.by_user(@user.id).between(params['wday'], params['wday']) 
    special = Specialavailability.by_user(@user.id).between(params['wday'], params['wday']) 
    unless special.empty?
      special.each do |spec|
        if spec.is_available == true
          @times << spec
        else
          unless @times.select{|x| x.date == spec.date}.empty?
            # must remove if it 
            @times.select{|x| x.date == spec.date}.each do |pot|
               if (pot.open_datetime..pot.close_datetime).overlaps?(spec.open_datetime..spec.close_datetime)
                 if spec.open_datetime <= pot.open_datetime
                   if spec.close_datetime >= pot.close_datetime
                     @times.delete(pot)
                   else
                     newpot = pot.dup
                     newpot.open_time = spec.close_time
                     @times.delete(pot)
                     @times << newpot
                   end
                 else
                   if spec.close_datetime >= pot.close_datetime
                     newpot = pot.dup
                     newpot.close_time = spec.open_time
                     @times.delete(pot)
                     @times << newpot
                   else
                     newpot = pot.dup
                     blah = pot.dup
                     
                     @times.delete(pot)
                     newpot.close_time = spec.open_time
                     blah.open_time = spec.close_time
                     @times << newpot
                     @times << blah
                   end
                 end
               end
             end
          end
        end
          
      end
    end
  end
  
  def calendar
    @booking = Booking.find(params[:id])
    @user = @booking.teacher
    @times = Regularavailability.by_user(@user.id).between(params['start'], params['end']) 
    special = Specialavailability.by_user(@user.id).between(params['start'], params['end']) 
    unless special.empty?
      special.each do |spec|
        if spec.is_available == true
          @times << spec
        else
          unless @times.select{|x| x.date == spec.date}.empty?
            # must remove if it 
            @times.select{|x| x.date == spec.date}.each do |pot|
               if (pot.open_datetime..pot.close_datetime).overlaps?(spec.open_datetime..spec.close_datetime)
                 if spec.open_datetime <= pot.open_datetime
                   if spec.close_datetime >= pot.close_datetime
                     @times.delete(pot)
                   else
                     newpot = pot.dup
                     newpot.open_time = spec.close_time
                     @times.delete(pot)
                     @times << newpot
                   end
                 else
                   if spec.close_datetime >= pot.close_datetime
                     newpot = pot.dup
                     newpot.close_time = spec.open_time
                     @times.delete(pot)
                     @times << newpot
                   else
                     newpot = pot.dup
                     blah = pot.dup
                     
                     @times.delete(pot)
                     newpot.close_time = spec.open_time
                     blah.open_time = spec.close_time
                     @times << newpot
                     @times << blah
                   end
                 end
               end
             end
          end
        end
          
      end
    end
    respond_to do |format|

      format.json { render :json => @times }

    end
  end
  
  def choose_timeslot
    @booking = Booking.find(params[:id])
  end
  
  def create

    @booking = Booking.new(booking_params)
    if params[:booking][:teacher_id] !~ /^\d*$/
    
      @booking.legacy_teacher = params[:booking][:teacher_id]
      @booking.teacher_id = 0
    else
      if @booking.teacher.regularavailabilities.empty? && @booking.teacher.specialavailabilities.empty?
        flash[:error] = 'This teacher has not yet defined any available times. Sorry!'
        redirect_to '/' and return
      end
    end
    if @booking.save
      if @booking.teacher_id == 0
        flash[:notice] = 'Your booking has been registered. When the teacher confirms, you will receive an email containing payment information.'
        redirect_to current_user
      else
        redirect_to choose_timeslot_booking_path(@booking)
      end
    else
      flash[:error] = 'There was an error in saving your booking. Please try again: ' + @booking.errors.join(' / ')
      render template: 'new'
    end
  end
  
  def destroy
    @booking = Booking.find(params[:id])
    if current_user == @booking.user || current_user == @booking.teacher || current_user.has_role?(:admin)
      @booking.destroy
      flash[:notice] = 'Your booking was canceled.'
    end
    redirect_to current_user    
  end
  
  def new
    @booking = Booking.new
  end
  
  def update
    @booking = Booking.find(params[:id])

    if @booking.update_attributes(booking_params)
      flash[:notice] = 'Your booking has been registered. When the teacher confirms, you will receive an email and must then pay for the class.'
      redirect_to current_user
    else
      flash[:error] = ' There was an error saving this booking.'
    end

  end
  
  protected
  
  def booking_params
    params.require(:booking).permit(:user_id, :teacher_id, :requested_start, :requested_finish, :teacher_approved, :fee_paid, :notes, :location, :custom_location) 
  end
  
end