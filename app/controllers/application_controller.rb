class ApplicationController < ActionController::Base
  layout :choose_layout
  # before_action :authenticate_user!

  def index; end

  protected

  def choose_layout
    user_signed_in? ? 'account' : 'application'
  end
end
