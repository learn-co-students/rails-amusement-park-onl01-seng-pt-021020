class Ride < ActiveRecord::Base
    validates :user_id, presence: true
    validates :attraction_id, presence: true
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if tall_enough? && enough_tickets?
            start_ride
        elsif tall_enough? && !enough_tickets?
            "Sorry. You do not have enough tickets to ride the #{attraction.name}."
        elsif !tall_enough? && enough_tickets?
            "Sorry. You are not tall enough to ride the #{attraction.name}."
        else
            "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
        end
    end

    private 

    def tall_enough?
        user.height >= attraction.min_height ? true : false
    end

    def enough_tickets?
        user.tickets >= attraction.tickets ? true: false
    end

    def start_ride
        user.nausea = user.nausea + attraction.nausea_rating
        user.happiness = user.happiness + attraction.happiness_rating
        user.tickets = user.tickets - attraction.tickets
        user.save
        "Thanks for riding the #{attraction.name}!"
    end


end
