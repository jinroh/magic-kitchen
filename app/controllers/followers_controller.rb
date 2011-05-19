class FollowersController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @followers = current_user.followers
    respond_with(@followers)
  end
  
  def show
    raise ActiveRecord::RecordNotFound unless current_user.followed_by?(params[:id])
    @follower = User.find(params[:id])
    respond_with(@follower)
  end
  
end