class ApplicationController < ActionController::Base
  include Pagy::Backend

  layout :choose_layout
  # before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def choose_layout
    admin_signed_in? ? 'account' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
