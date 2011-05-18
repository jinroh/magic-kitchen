class LikesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @likes = current_user.likes.includes(:recipe)
    respond_with @likes
  end
  
  def create
    @like = current_user.likes.build(params)
    respond_with @like
  end

  def destroy
    @like = Like.by(current_user).for(params[:recipe])
    respond_with(@like, :location => @like.recipe)
  end
  
end
