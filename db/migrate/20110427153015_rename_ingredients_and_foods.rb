class RenameIngredientsAndFoods < ActiveRecord::Migration
  def self.up
    rename_table :ingredients, :recipes_ingredients
    rename_table :foods, :ingredients
    
    change_table :recipes_ingredients do |t|
      t.rename :food_id, :ingredient_id
    end
  end

  def self.down
    change_table :recipes_ingredients do |t|
      t.rename :ingredient_id, :food_id
    end
    
    rename_table :ingredients, :foods
    rename_table :ingredients_recipes, :ingredients
  end
end