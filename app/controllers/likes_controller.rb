class LikesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @likes = current_user.likes.includes(:recipe)
    respond_with @likes
  end
  
  def show
    @like = Like.by(current_user).for(params[:id]).all.first
    raise ActiveRecord::RecordNotFound if @like.nil?
    respond_with @like
  end
  
  def create
    @like = current_user.likes.build(:recipe_id => params[:recipe_id])
    @like.save
    respond_with @like
  end

  def destroy
    @like = Like.by(current_user).for(params[:id]).all.first
    raise ActiveRecord::RecordNotFound if @like.nil?
    @like.destroy
    respond_with(@like, :location => @like.recipe)
  end
  
end
