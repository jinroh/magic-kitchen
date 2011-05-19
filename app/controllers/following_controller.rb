class FollowingController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @following = current_user.following
    respond_with(@following)
  end
  
  def show
    raise ActiveRecord::RecordNotFound unless current_user.following?(params[:id])
    @following = User.find(params[:id])
    respond_with(@following)
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