class ApplicationController < ActionController::Base
  add_flash_types :alert, :msg
  protect_from_forgery with: :exception
  before_action :current_user

  def home
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
    if !@current_user && root_path
      return false
    elsif @current_user && root_path
      return @current_user
    else !@current_user && !root_path
      redirect_to root_path
    end
  end
  
end
