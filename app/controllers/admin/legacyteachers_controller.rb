class Admin::LegacyteachersController < Admin::BaseController
  
  
  def destroy
    @legacyteacher = Legacyteacher.find params[:id]
    if @legacyteacher.destroy!
      flash[:notice] = 'This legacy teacher has been destroyed.'
      redirect_to admin_legacyteachers_path
    end
  end
  
  def edit
    @legacyteacher = Legacyteacher.find params[:id]
    if cannot? :edit, @legacyteacher
      flash[:notice] = 'You do not have permission to edit legacyteachers.'
      redirect_to admin_legacyteachers_path
    end
  end
  
  def index
    @legacyteachers = Legacyteacher.all
  end
  
  
  def update
    @legacyteacher = Legacyteacher.find(params[:id])
    if cannot? :edit, @legacyteacher
      flash[:error] = 'Cannot edit legacyteacher profile.'
    else
      if @legacyteacher.update_attributes(legacyteacher_params)
        flash[:notice] = 'Updated legacyteacher profile.'
        redirect_to admin_legacyteachers_path
      else
        flash[:error] = @legacyteacher.errors.inspect
        if @legacyteacher.applied_as_teacher == 1
          render template: 'register_as_teacher'
        else
          render template: 'register_as_student'
        end
      end
    end
  end
  
  protected
  
  def legacyteacher_params
    params.require(:legacyteacher).permit(:name, :email)
  end
  
  
end