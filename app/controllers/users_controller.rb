class UsersController < ApplicationController
  def new
    if logged_in
      redirect_to "/"
    else
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      redirect_to '/users/new'
    end
  end

  def show
    if logged_in
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to '/'
    end
  end

  def welcome
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :tickets, :happiness, :nausea, :height, :admin)
  end

end
