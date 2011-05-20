class LikesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @likes = current_user.likes.includes(:recipe)
    respond_with @likes
  end
  
  def show
    @like = Like.by(current_user).for(params[:id])
    raise ActiveRecord::RecordNotFound if @like.empty?
    respond_with @like
  end
  
  def create
    @like = current_user.likes.build(params[:recipe_id]).save
    respond_with @like
  end

  def destroy
    @like = Like.by(current_user).for(params[:id])
    respond_with(@like, :location => @like.recipe)
  end
  
end
