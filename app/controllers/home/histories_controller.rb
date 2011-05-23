class Home::HistoriesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @recipes = current_user.cooked_recipes
    respond_with(@recipes)
  end
  
  def show
    @histories = current_user.histories.for(params[:id])
    respond_with @histories
  end
  
  def create
    @history = current_user.histories.build(:recipe_id => params[:recipe_id])
    @history.save
    respond_with @history
  end
  
end