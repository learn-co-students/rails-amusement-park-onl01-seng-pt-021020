require 'pry'
class AttractionsController < ApplicationController
  before_action :current_user
  def index
    if @current_user.admin 
      @attractions = Attraction.all
      render "admin_index" 
    else
      @attractions = Attraction.all
      render "index" 
    end    
  end

  def new
    @attraction = Attraction.new
  end

  def show
    @attraction = Attraction.find_by(id: params[:id])
    @user = User.find_by(id: current_user)
    if @current_user.admin
      render "admin_show"
    else
      render "show"
    end
  end
  
  def create
    if current_user.admin
      @attraction = Attraction.create(at_params)
      redirect_to @attraction
    else
      redirect_to user_path(current_user)
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    attraction = Attraction.find_by(id: params[:id])
    if @current_user.admin
      attraction.update(at_params)

      redirect_to attraction
    else
      ride = Ride.new(user_id: current_user.id, attraction_id: params[:id])
      current_user.rides << ride
      attraction.rides << ride
     flash[:message] = ride.take_ride
    redirect_to user_path(current_user) 
    end
  end

  private
  def at_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height, :admin)    
  end
end