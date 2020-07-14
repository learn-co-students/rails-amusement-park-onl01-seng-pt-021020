class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    message = "Sorry."
    if user.tickets < attraction.tickets
      message += " You do not have enough tickets to ride the #{attraction.name}."
    end
    if user.height < attraction.min_height
      message += " You are not tall enough to ride the #{attraction.name}."
    end
    if message.length > 6
      return message
    else
      user.tickets -= attraction.tickets
      user.nausea += attraction.nausea_rating
      user.happiness += attraction.happiness_rating
      user.save
    end
  end
end
