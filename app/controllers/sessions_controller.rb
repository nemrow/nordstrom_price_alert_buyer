class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      create_user_session_cookie(user)
      redirect_to user_path(user)
    else
      redirect_to login_path(:error => "could not log in")
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
