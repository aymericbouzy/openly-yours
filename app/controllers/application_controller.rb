class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :warning

  before_filter :set_new_user

  def set_new_user
    @new_user ||= User.new
  end
end
