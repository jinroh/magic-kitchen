class CreateIngredientsRecipes < ActiveRecord::Migration
  def self.up
    create_table :ingredients_recipes, :id => false do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
    end
  end

  def self.down
    drop_table :ingredients_recipes
  end
end
