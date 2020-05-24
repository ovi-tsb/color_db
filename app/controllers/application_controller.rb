class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    inks_path # or any other path needed
  end

  def after_update_path_for(resource)
    inks_path
  end

  before_action :set_current_user

    def set_current_user
      User.current_user = current_user if current_user
    end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :title])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :title])
    end
  
end
