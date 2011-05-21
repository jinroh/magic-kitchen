class RecipesIngredientsIndexNoLimit < ActiveRecord::Migration
  def self.up
    drop_table :recipes_ingredients
    
    create_table :recipes_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.string  :quantity
    end
    
    add_index :recipes_ingredients, [:recipe_id, :ingredient_id], :unique => true
  end

  def self.down
  end
end