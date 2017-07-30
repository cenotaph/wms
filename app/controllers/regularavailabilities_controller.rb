class RegularavailabilitiesController < ApplicationController
  before_action :authenticate_user!
  
  
  def by_day
    @regularavailabilities = Regularavailability.by_user(current_user.id).by_dayofweek(params[:wday])
    @day = params[:wday]
    @regularavailability = Regularavailability.new
  end
  
  def create
    @regularavailability = Regularavailability.new(available_params)
    if @regularavailability.save
      flash[:notice] = 'Your hours have been saved.'
      redirect_to regularavailabilities_path
    end
  end
  
  def edit
    @regularavailability = Regularavailability.find params[:id]
    @day = @regularavailability.day_of_week
    render template: 'regularavailabilities/by_day'
  end
  
  def destroy
    @regularavailability = Regularavailability.find params[:id]
    if @regularavailability.destroy!
      flash[:notice] = 'These hours have been removed from your calendar.'
      redirect_to regularavailabilities_path
    end
  end
  
  def update
    @regularavailability = Regularavailability.find(params[:id])

    if cannot? :edit, @regularavailability
      flash[:error] = 'Cannot edit this calendar.'
    else
      if @regularavailability.update_attributes(available_params)
        flash[:notice] = 'Updated your calendar.'

      else
        flash[:error] = ' There was an error saving these hours.'
      end
      redirect_to regularavailabilities_path
    end
  end
    
  def index
    @regularavailabilities = Regularavailability.by_user(current_user.id)
    @specialavailabilities = Specialavailability.by_user(current_user.id)
  end
  
  private
  
  def available_params
    params.require(:regularavailability).permit(:day_of_week, :user_id, :open_time, :close_time)    
  end
  
end