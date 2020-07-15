class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if !enough_tickets? && !tall_enough?
            "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
        elsif !enough_tickets? 
            "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
        elsif !tall_enough?
            "Sorry. You are not tall enough to ride the #{self.attraction.name}."
        else
            update_tickets
            update_nausea
            update_happiness
            "Thanks for riding the #{self.attraction.name}!"
        end
    end

    def enough_tickets?
        self.user.tickets >= self.attraction.tickets
    end

    def tall_enough?
        self.user.height >= self.attraction.min_height
    end


    def update_tickets
        updated_t = self.user.tickets - self.attraction.tickets
        self.user.tickets = updated_t
        self.user.save
    end

    def update_nausea
        updated_n = self.user.nausea + self.attraction.nausea_rating
        self.user.nausea = updated_n
        self.user.save
    end

    def update_happiness
        updated_h = self.user.happiness + self.attraction.happiness_rating
        self.user.happiness = updated_h
        self.user.save
    end

end
