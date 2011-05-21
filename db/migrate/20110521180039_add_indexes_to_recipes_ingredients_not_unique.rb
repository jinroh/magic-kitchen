class AddIndexesToRecipesIngredientsNotUnique < ActiveRecord::Migration
  def self.up
    remove_index :likes, :column => [:user_id, :recipe_id]
    add_index :recipes_ingredients, [:recipe_id, :ingredient_id], :unique => false
  end

  def self.down
  end
end