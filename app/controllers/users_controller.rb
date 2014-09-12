class UsersController < ApplicationController
  before_filter :user_required, :only=>[:show, :update, :edit, :destroy]

  def new
    @user = User.new
  end

  def show

  end

  def create
    user = User.create(params[:user])
    if user
      create_user_session_cookie(user)
      redirect_to user_path(user)
    else
      redirect_to new_user_path
    end
  end

  def update

  end

  def edit

  end

  def destroy

  end
end
