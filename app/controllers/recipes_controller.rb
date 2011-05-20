class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :load_recipe, :except => [:index, :new, :create]
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @recipes = Recipe.search(params[:search])
                     .with_ingredients(params[:with])
                     .with_ingredients(params[:without], :exclude => true)
                     .page(params[:page]).per(5)
    respond_with @recipes
  end
  
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    
    respond_with @recipe
  end

  def create
    @recipe = current_user.recipes.build(params)
    flash[:notice] = "Your recipe has been added" if @recipe.save
    respond_with @recipe
  end
  
  def show
    respond_with @recipe
  end
  
  def edit
    @recipe.ingredients.build
    respond_with @recipe
  end
  
  def update
    flash[:notice] = "Recipe successfully updated" if @recipe.update_attributes(params)
    respond_with @recipe
  end

  def destroy
    flash[:notice] = "Recipe successfully deleted" if @recipe.destroy
    respond_with(@recipe, :location => user_root_path)
  end
  
  private
  
  def load_recipe
    @recipe = Recipe.find(params[:id])
  end
end
