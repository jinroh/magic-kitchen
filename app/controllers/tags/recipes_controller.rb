class Tags::RecipesController < ApplicationController
  respond_to :xml, :json

  def ingredients
    @ingredients = Ingredient.all.map(&:name)
    respond_with @ingredients
  end
  
  def tags
    @tags = Tag.all.map(&:name)
    respond_with @tags
  end
  
end
