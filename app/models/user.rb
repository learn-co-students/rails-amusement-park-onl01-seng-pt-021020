class User < ActiveRecord::Base
    has_secure_password
    
    has_many :rides
    has_many :attractions, through: :rides

    def mood
        case happiness <=> nausea
        when -1
          'sad'
        when 1
          'happy'
        end
    end
    
    def height_check(attraction)
        height >= attraction.min_height
    end
    
    def ticket_check(attraction)
        tickets >= attraction.tickets
    end
end
