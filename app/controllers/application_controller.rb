class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about, :index, :show, :search], unless: :admin_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :profile_image])
  end
end