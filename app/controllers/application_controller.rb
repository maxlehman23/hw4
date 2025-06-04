class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def current_user
    @current_user
  end

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to see that page."
      redirect_to login_path
    end
  end
end