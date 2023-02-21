class UsersController < ApplicationController
    def show
        @user = User.find(params[:id]) 
    end

    def update
        @user = User.find(params[:id])
        if params[:id]
            @user.image_url = "#{@user.id}.jpg"
            image = params[:image]
        end
    end
end
