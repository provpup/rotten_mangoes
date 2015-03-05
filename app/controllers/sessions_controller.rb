class SessionsController < ApplicationController
  before_filter :restrict_admin_access, only: [:impersonate, :remove_persona]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: 'Adios!'
  end

  def create_persona
    session[:admin_user_id] = current_user.id
    session[:user_id] = params[:id]
    user = User.find(session[:user_id])
    redirect_to movies_path, notice: "Now impersonating as #{user.full_name}"
  end

  def destroy_persona
    session[:user_id] = session[:admin_user_id]
    redirect_to movies_path, notice: "Back to admin #{current_user.full_name}"
  end
end
