class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if attraction.tickets > user.tickets && attraction.min_height > user.height
      "Sorry. You do not have enough tickets to ride the Roller Coaster. You are not tall enough to ride the Roller Coaster."
    elsif attraction.min_height > user.height
      "Sorry. You are not tall enough to ride the Roller Coaster."
    elsif attraction.tickets > user.tickets
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    else
      user.update(tickets: user.tickets -= attraction.tickets)
      user.update(nausea: user.nausea += attraction.nausea_rating)
      user.update(happiness: user.happiness += attraction.happiness_rating)
    end
  end
end
