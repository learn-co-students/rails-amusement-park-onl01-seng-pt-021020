module ApplicationHelper
    def logged_out
        !session.include? :user_id
    end
end
