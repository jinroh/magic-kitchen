class FollowersController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @following = current_user.following
    respond_with(@following)
  end
  
  def show
    @following = current_user.find(params[:id])
    respond_with(@following)
  end
  
end