class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'destroy' }
end
