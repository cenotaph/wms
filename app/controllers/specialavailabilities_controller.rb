class SpecialavailabilitiesController < ApplicationController
  before_action :authenticate_user!

  
  def create
    @specialavailability = Specialavailability.new(available_params)
    if @specialavailability.save
      flash[:notice] = 'Your hours have been saved.'
      redirect_to regularavailabilities_path
    end
  end
  
  
  def edit
    @specialavailability = Specialavailability.find params[:id]
  

  end
  
  def destroy
    @specialavailability = Specialavailability.find params[:id]
    if @specialavailability.destroy!
      flash[:notice] = 'These hours have been removed from your calendar.'
      redirect_to regularavailabilities_path
    end
  end
  
  def new
    @specialavailability = Specialavailability.new
  end
  
  def update
    @specialavailability = Specialavailability.find(params[:id])

    if cannot? :edit, @specialavailability
      flash[:error] = 'Cannot edit this calendar.'
    else
      if @specialavailability.update_attributes(available_params)
        flash[:notice] = 'Updated your calendar.'

      else
        flash[:error] = ' There was an error saving these hours.'
      end
      redirect_to regularavailabilities_path
    end
  end
    
  def index
    redirect_to regularavailabilities_path
    # @specialavailabilities = Specialavailability.by_user(current_user.id)
  end
  
  private
  
  def available_params
    params.require(:specialavailability).permit(:date, :is_available, :user_id, :open_time, :close_time)    
  end
  
end