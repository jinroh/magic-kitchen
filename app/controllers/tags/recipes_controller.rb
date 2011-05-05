class Tags::RecipesController < ApplicationController
  respond_to :xml, :json
  
  def index
    @tags = Tag.includes(:taggings).where(:taggings => { :taggable_type => "Recipe" })
    
    if params[:q]
      @tags = @tags.where("name LIKE ?", params[:q] + "%")
    end
    respond_with @tags
  end
  
  def show
    @tags = Tag.includes(:taggings).where(:taggings => { :taggable_type => "Recipe", :recipe_id => params[:id] })
    respond_with @tags
  end
end
