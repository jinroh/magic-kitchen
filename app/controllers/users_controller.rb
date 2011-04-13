class UsersController < ApplicationController
    
  # GET /user/
  def index
    @user = current_user if user_signed_in?
    render :find
  end

  # GET /user/:login
  def show
    @user = User.find_by_login( params[:login] )
    raise ActiveRecord::RecordNotFound unless @user
  end

end
