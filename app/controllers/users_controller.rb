class UsersController < ApplicationController

    def create
      @user = User.new(user_params)
      
      if @user.save
        render json: {
          user: {
            username: @user.username,
            email: @user.email
          }
        }
      else
        render json: {success: false}
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  
  end
  