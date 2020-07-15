class SessionsController < ApplicationController
    def new
        if logged_in
            redirect_to '/'
        else
            render :signin
        end
    end

    def create
        @user = User.find_by(name: params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id 
            redirect_to "/users/#{@user.id}"
        else
            redirect_to '/signin'
        end
    end

    def destroy
        session.delete :user_id
        redirect_to '/'
    end
end