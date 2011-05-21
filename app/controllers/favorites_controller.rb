class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  respond_to :html, :json

  def index
    @favorite_recipes = current_user.favorite_recipes
    respond_with @favorite_recipes
  end

  def show
    @favorite = Favorite.by(current_user).for(params[:id]).all.first
    raise ActiveRecord::RecordNotFound if @favorite.nil?
    respond_with @favorite
  end

  def create
    @favorite = current_user.favorites.build(:recipe_id => params[:recipe_id])
    @favorite.save
    respond_with @favorite
  end

  def destroy
    @favorite = Like.by(current_user).for(params[:id]).all.first
    raise ActiveRecord::RecordNotFound if @favorite.nil?
    @favorite.destroy
    respond_with(@favorite, :location => @favorite.recipe)
  end
end