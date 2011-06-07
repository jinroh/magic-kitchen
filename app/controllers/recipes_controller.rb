class RecipesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :load_recipe, :except => [:index, :new, :create]
  before_filter :recipe_params, :only => [:create, :update] 
  authorize_resource
  
  respond_to :html, :json
  
  def index
    @recipes = Recipe.search(params[:search])
                     .with_ingredients(params[:with_ingredients])
                     .with_ingredients(params[:without], :exclude => true)
                     .page(params[:page]).per(5)
                     .includes(:ingredients, :user, :tags)
                     
    if user_signed_in?
      @likes     = current_user.likes.for(@recipes)
      @favorites = current_user.favorites.for(@recipes)
      @histories = current_user.histories.for(@recipes)
    end
    
    respond_with @recipes do |format|
      format.json { render 'recipes' }
    end
  end
  
  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    
    respond_with @recipe do |format|
      format.json { render 'recipe' }
    end
  end

  def create
    @recipe = current_user.recipes.build(@recipe_params)
    flash[:notice] = "Your recipe has been added" if @recipe.save!
    respond_with @recipe do |format|
      format.json { render 'recipe' }
    end
  end
  
  def show
    respond_with @recipe do |format|
      format.json { render 'recipe' }
    end
  end
  
  def edit
    @recipe.ingredients.build
    respond_with @recipe do |format|
      format.json { render 'recipe' }
    end
  end
  
  def update
    flash[:notice] = "Recipe successfully updated" if @recipe.update_attributes(@recipe_params)
    respond_with @recipe do |format|
      format.json { render 'recipe' }
    end
  end

  def destroy
    flash[:notice] = "Recipe successfully deleted" if @recipe.destroy
    respond_with(@recipe, :location => user_root_path) do |format|
      format.json { render 'recipe' }
    end
  end
  
  private
  
  def load_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    @recipe_params = params[:recipe] || params
  end
end
