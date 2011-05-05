class UsersController < ApplicationController
  
  # GET /user/
  def index
    @user = current_user if user_signed_in?
  end

  # GET /user/:login
  def show
    @user = User.find(params[:id])
  end

end
