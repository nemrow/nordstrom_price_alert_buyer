class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_required
    if @user = User.find_by_id(session[:user_id]) || User.find_by_id(params[:user_id])
      return @user
    else
      redirect_to login_path
      return false
    end
  end

  def create_user_session_cookie(user)
    session[:user_id] = user.id
  end
end
