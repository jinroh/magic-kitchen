class RecipesController < ApplicationController
  include Canable::Enforcers
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_recipe, :except => [:index, :new, :create]
  
  respond_to :html, :json
  
  def index
    @recipes = Recipe.search(params[:search])
                     .with_ingredients(params[:with])
                     .with_ingredients(params[:without], :exclude => true)
                     .page(params[:page]).per(5)
  end
  
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    
    enforce_create_permission @recipe
  end

  def create
    @recipe = current_user.recipes.build(params[:recipe])
    enforce_create_permission @recipe
    
    if @recipe.save!
      flash[:notice] = "Your recipe has been added"
      redirect_to user_root_path
    else
      render 'new'
    end
  end
  
  def show
    enforce_view_permission @recipe
    @tags = @recipe.tag_counts_on(:tags)
    
    respond_with @recipe
  end
  
  def edit
    enforce_update_permission @recipe
    @recipe.ingredients.build
    
    respond_with @recipe
  end
  
  def update
    enforce_update_permission @recipe
    
    flash[:notice] = "Recipe successfully updated" if @recipe.update_attributes(params[:recipe])
    respond_with @recipe
  end

  def destroy
    enforce_destroy_permission @recipe
    
    if @recipe.destroy
      redirect_to user_root_path
    else
      render show
    end
  end
  
  private
  
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def find_recipe_with_ingredients
    @recipe = Recipe.find(params[:id]).includes(:ingredients)
  end
end
