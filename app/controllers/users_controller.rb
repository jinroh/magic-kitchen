class UsersController < ApplicationController
  before_filter :load_user, :except => :index
  
  respond_to :html, :json
  
  def index
  end

  def show
    respond_with @user
  end
  
  def followers
    @followers = @user.followers
    respond_with @followers
  end
  
  def following
    @following = @user.following
    respond_with @following
  end
  
  private
  def load_user
    @user = User.find(params[:id])
  end
  
end
