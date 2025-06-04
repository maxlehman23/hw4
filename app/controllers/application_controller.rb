class ApplicationController < ActionController::Base
  helper_method :current_user  # make it available in views

  def current_user
    # memoize so we don't query multiple times per request
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end