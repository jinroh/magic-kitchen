class FollowersController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @followers = current_user.followers
    @following = current_user.following
    respond_with({:followers => @followers,
                  :following => @following})
  end
  
  def create
    @following = User.find(params[:id])
    current_user.follow!(@following) unless current_user == @following
    respond_with(@following) do |format|
      format.html { redirect_to @following }
    end
  end
  
  def destroy
    @following = User.find(params[:id])
    current_user.unfollow!(@following) unless current_user == @following
    respond_with(@following) do |format|
      format.html { redirect_to @following }
    end
  end
  
end