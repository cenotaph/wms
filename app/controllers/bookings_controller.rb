class BookingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @booking = Booking.new(booking_params)
    if params[:booking][:teacher_id] !~ /^\d*$/
    
      @booking.legacy_teacher = params[:booking][:teacher_id]
      @booking.teacher_id = 0
    end
    if @booking.save
      flash[:notice] = 'Your booking has been registered. You will receive further information soon by email.'
      redirect_to current_user
    else
      flash[:error] = 'There was an error in saving your booking. Please try again: ' + @booking.errors.join(' / ')
      render template: 'new'
    end
  end
  
  def new
    @booking = Booking.new
  end
  
  protected
  
  def booking_params
    params.require(:booking).permit(:user_id, :teacher_id, :requested_start, :requested_finish, :teacher_approved, :fee_paid, :notes, :location, :custom_location) 
  end
  
end