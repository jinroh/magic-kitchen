class RemoveIndexesFromRecipesIngredients < ActiveRecord::Migration
  def self.up
    remove_index :recipes_ingredients, :recipe_id_and_ingredient_id
  end

  def self.down
  end
end