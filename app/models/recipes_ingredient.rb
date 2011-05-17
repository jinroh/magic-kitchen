# == Schema Information
#
# Table name: recipes_ingredients
#
#  id            :integer         not null, primary key
#  recipe_id     :string(255)
#  ingredient_id :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  quantity      :string(255)
#

class RecipesIngredient < ActiveRecord::Base
  
  attr_accessible :ingredient_id,
                  :recipe_id,
                  :quantity
  
  belongs_to :ingredient
  belongs_to :recipe, :touch => true

  validates_presence_of :ingredient_id
  validates_uniqueness_of :ingredient_id, :scope => :recipe_id 
  
  def name
    ingredient.name
  end
  
  def name=(object)
    ingredient.name = object
  end
  
end

