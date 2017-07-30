class Admin::UsersController < Admin::BaseController
  
  
  def edit
    @user = User.friendly.find params[:id]
    if cannot? :edit, @user
      flash[:notice] = 'You do not have permission to edit users.'
      redirect_to admin_users_path
    end
  end
  
  def index
    @users = User.all
  end
  
  
  def update
    @user = User.friendly.find(params[:id])
    if cannot? :edit, @user
      flash[:error] = 'Cannot edit user profile.'
    else
      if @user.update_attributes(user_params)
        flash[:notice] = 'Updated user profile.'
        redirect_to admin_users_path
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
  
  protected
  
  def user_params
    params.require(:user).permit(:name, :email, :username, :main_instrument, :other_instrument, :slug, :address, :in_helsinki, :city, :birthdate, :parental_name, :website, :facebook, :twitter, :other_links, :avatar, :publications, :summary,  :hourly_rate, :custom_hourly_rate, :availability_id, :experienced, :has_own_instrument, :desired_lessons, :lesson_time, :howdidfind_id, :applied_as_teacher, :applied_as_student, :approved_teacher, :approved_student, :cv, :other_languages, :custom_teaching_level, :custom_hours, :custom_teachinglocation,  :custom_howdidfind)
  end
  
  
end