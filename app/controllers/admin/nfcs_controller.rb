class Admin::NfcsController < Admin::BaseController

  def create
    @nfc = Nfc.new(nfc_params)
    if @nfc.save
      flash[:notice] = 'This ID card has been created.'
      redirect_to admin_users_path
    end
  end

  def destroy
    @nfc = Nfc.find params[:id]
    if @nfc.destroy!
      flash[:notice] = 'This ID card has been destroyed.'
      redirect_to admin_users_path
    end
  end

  def edit
    @nfc = Nfc.find params[:id]
    if params[:user_id]
      @user = User.friendly.find(params[:user_id])
    else
      @user = @nfc.user
    end
    if cannot? :edit, @nfc
      flash[:notice] = 'You do not have permission to edit nfcs.'
      redirect_to admin_users_path
    end
  end

  def index
    if params[:user_id]
      @user = User.friendly.find(params[:user_id])
      @nfcs = Nfc.by_user(@user.id)
    else
      @nfcs = Nfc.all
    end
  end

  def new
    @user = User.friendly.find(params[:user_id])
    @nfc = Nfc.new(user: @user)
  end

  def update
    @nfc = Nfc.find(params[:id])
    if cannot? :edit, @nfc
      flash[:error] = 'Cannot edit nfc profile.'
    else
      if @nfc.update_attributes(nfc_params)
        flash[:notice] = 'Updated nfc profile.'
        redirect_to admin_users_path
      else
        flash[:error] = @nfc.errors.inspect
        if @nfc.applied_as_teacher == 1
          render template: 'register_as_teacher'
        else
          render template: 'register_as_student'
        end
      end
    end
  end

  protected

  def nfc_params
    params.require(:nfc).permit(:user_id, :tag_address, :collected, :active)
  end


end
