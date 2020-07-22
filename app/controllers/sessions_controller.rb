class SessionsController < ApplicationController
  before_action :current_user

  def new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end