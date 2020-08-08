class UsersController < ApplicationController
    before_action :require_login, only: :show
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user
      end
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def signin
      @users = User.all
      @user = User.new
    end
  
    def login
      @user = User.find_by(name: user_params[:name])
      if @user && @user.authenticate(user_params[:password])
        session[:user_id] = @user.id
        redirect_to @user
      end
    end
  
    def signout
      session.clear
      redirect_to root_path
    end
  
    private
  
    def user_params
      params.require(:user).permit([:name, :password, :nausea, :happiness, :tickets, :height, :admin])
    end
  
    def require_login
      redirect_to root_path if session[:user_id].nil?
    end
  end