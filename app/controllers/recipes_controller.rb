class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
  end
  
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(params[:recipe])
    if @recipe.save
      flash[:notice] = "Your recipe has been added"
      redirect_to user_root_path
    else
      render 'new'
    end
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      flash[:notice] = "Recipe successfully updated"
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to user_root_path
    else
      render show
    end
  end
  
end
