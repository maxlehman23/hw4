class SessionsController < ApplicationController
  def new
    # Renders the login form
  end

  def create
    @user = User.find_by(email: params[:email])

    # If you are storing password hashes manually:
    if @user && BCrypt::Password.new(@user.password) == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "Hello, #{@user.username}"
      redirect_to places_path
    else
      flash[:alert] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Goodbye."
    redirect_to login_path
  end
end