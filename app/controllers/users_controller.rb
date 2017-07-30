class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def calendar
    @times = Regularavailability.by_user(params[:id]).between(params['start'], params['end']) 
    special = Specialavailability.by_user(params[:id]).between(params['start'], params['end']) 
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
      format.html # index.html.erb
      format.json { render :json => @times }

    end
  end
  
  def update
    @user = User.friendly.find(params[:id])
    if @user != current_user
      flash[:error] = 'Cannot edit another user profile.'
    else
      if @user.update_attributes(user_params)
        flash[:notice] = 'Updated user profile.'
        redirect_to '/'
      else
        flash[:error] = @user.errors.inspect
        if @user.applied_as_teacher == 1
          render template: 'register_as_teacher'
        else
          render template: 'register_as_student'
        end
      end
    end
  end
  
  def register_as_teacher
    @user = current_user
    @user.applied_as_teacher = true
    @user.images.build
    @user.images.build
  end
  
  def register_as_student
    @user = current_user
    @user.applied_as_student = true
    @user.images.build
    @user.images.build
  end
  
  def show
    @user = current_user
  end
  
  
  protected
  
  def user_params
    params.require(:user).permit(:name, :email, :username, :main_instrument, :other_instrument, :slug, :address, :in_helsinki, :city, :birthdate, :parental_name, :website, :facebook, :twitter, :other_links, :avatar, :publications, :summary,  :hourly_rate, :custom_hourly_rate, :availability_id, :experienced, :has_own_instrument, :desired_lessons, :lesson_time, :howdidfind_id, :applied_as_teacher, :applied_as_student,  :cv, :other_languages, :custom_teaching_level, :custom_hours, :custom_teachinglocation,  :custom_howdidfind, :custom_experience, :custom_hasinstrument, :custom_lessontime, :custom_havelessons, :custom_instrumentgenre, :custom_teacher, :further_comments, :voucher, :specific_teacher, :desired_teacher, :other_instrument)
  end
  
end