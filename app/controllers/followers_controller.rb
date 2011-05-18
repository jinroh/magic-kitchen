class FollowersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @followers = User.find(params[:id]).followers
    @following = User.find(params[:id]).following
  end
  
  def create
    @following = User.find(params[:id])
    current_user.follow!(@following)
    respond_to do |format|
      format.html { redirect_to @following }
      format.all  { render :nothing => true }
    end
  end
  
  def destroy
    @following = User.find(params[:id])
    current_user.unfollow!(@following)
    respond_to do |format|
      format.html { redirect_to @following }
      format.all  { render :nothing => true }
    end
  end
  
end