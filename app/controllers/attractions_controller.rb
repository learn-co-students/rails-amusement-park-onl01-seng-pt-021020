class AttractionsController < ApplicationController
  before_action :set_user


  def index
    @attractions = Attraction.all
    if @user.admin
      render :admin_index
    end
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)

    redirect_to @attraction
  end

  def show
    @attraction = Attraction.find(params[:id])

    if @user.admin
      render :admin_show
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])

    if @user.admin
      @attraction.update(attraction_params)

      redirect_to @attraction
    else
      if @user.height_check(@attraction) && @user.ticket_check(@attraction)
        @user.tickets -= @attraction.tickets
        @user.happiness += @attraction.happiness_rating
        @user.nausea += @attraction.nausea_rating

        @user.save

        flash[:message] = "Thanks for riding the #{@attraction.name}!"
      elsif @user.ticket_check(@attraction)
        flash[:message] = "You are not tall enough to ride the #{@attraction.name}."
      elsif @user.height_check(@attraction)
        flash[:message] = "You do not have enough tickets to ride the #{@attraction.name}."
      else
        flash[:message] = "You are not tall enough to ride the #{@attraction.name}. You do not have enough tickets to ride the #{@attraction.name}."
      end

      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end

  def attraction_params
    params.require(:attraction).permit([:name, :min_height, :happiness_rating, :nausea_rating])
  end
end
