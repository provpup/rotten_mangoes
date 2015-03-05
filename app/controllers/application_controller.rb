class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in"
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def restrict_admin_access
    unless current_user && current_user.admin?
      redirect_to movies_path, notice: 'You must be admin to access admin pages'
    end
  end

  def original_admin_user
    @original_admin_user ||= User.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  helper_method :current_user
  helper_method :original_admin_user
end
