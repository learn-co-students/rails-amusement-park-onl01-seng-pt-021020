class RidesController < ApplicationController
    
    def create
        @ride = Ride.new(user_id: current_user.id, attraction_id: params[:id])
        if @ride.save
            redirect_to user_path(current_user), notice: @ride.take_ride
        else
            redirect_to attraction_path(@ride.attraction), notice: "#{@ride.attraction.name} was not ridden."
        end
    end

end