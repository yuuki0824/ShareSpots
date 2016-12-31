class ApplicationController < ActionController::Base
  before_action :configure_permitted_parametars, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def configure_permitted_parametars
    # sign_inのときに、usernameも許可する
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    # sign_upのときに、usernameも許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #  account_updateのときに、usernameも許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
