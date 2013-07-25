class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :password_confirmation, :name, :email, :company, :dept, :position, :hometown, :china_school1, :china_school2, :us_school1, :us_school2,
      :avatar ) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:password, :name, :remember_me)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:current_password, :password, :password_confirmation, :email, :company, :dept, :position, :hometown, :china_school1, :china_school2, :us_school1, :us_school2,
      :avatar ) } 
  end
  
end
