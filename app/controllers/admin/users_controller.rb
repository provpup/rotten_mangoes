class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, admin #{@user.firstname}!"
    else
      render :new
    end
  end

  protected
    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
    end

    def restrict_admin_access
      unless current_user && current_user.admin?
        redirect_to movies_path, notice: 'You must be admin to access admin pages'
      end
    end

end