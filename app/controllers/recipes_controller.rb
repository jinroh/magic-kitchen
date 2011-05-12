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
  end
  
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
  end

  def create
    @recipe = current_user.recipes.build(params[:recipe])
    if @recipe.save!
      flash[:notice] = "Your recipe has been added"
      redirect_to user_root_path
    else
      render 'new'
    end
  end
  
  def show
    @tags = @recipe.tag_counts_on(:tags)
    respond_with @recipe
  end
  
  def edit
    @recipe.ingredients.build
    respond_with @recipe
  end
  
  def update
    flash[:notice] = "Recipe successfully updated" if @recipe.update_attributes(params[:recipe])
    respond_with @recipe
  end

  def destroy
    if @recipe.destroy
      redirect_to user_root_path
    else
      render show
    end
  end
  
  private
  
  def load_recipe
    @recipe = Recipe.find(params[:id])
  end
end
