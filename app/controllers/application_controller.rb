class ApplicationController < ActionController::Base
  layout :choose_layout
  # before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def choose_layout
    admin_signed_in? ? 'account' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
