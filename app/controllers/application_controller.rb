class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #force_ssl
  #before_action :set_locale
  before_action :require_login
  
  private
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def require_login
    unless logged_in?
      flash.now[:error] = "You must be logged in to access this site"
      redirect_to login_path
    end
  end
  
  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end
  
  def logged_in?
    current_user != nil
  end
  
  helper_method :current_user, :logged_in?
  
end
