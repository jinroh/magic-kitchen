class Tags::RecipesController < ApplicationController
  respond_to :xml, :json

  def ingredients
    @ingredients = Ingredient.all.map(&:name)
    respond_with @ingredients
  end
  
  def tag
    @tags
  end
  
end
