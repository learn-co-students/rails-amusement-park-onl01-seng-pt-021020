class StaticController < ApplicationController
    skip_before_action :verify_authentication, only: [:home]

    def home
    end

end
