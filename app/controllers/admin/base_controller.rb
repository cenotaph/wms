class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  
  def authenticate_admin!
    redirect_to root_path unless current_user.has_role? :admin
  end
end