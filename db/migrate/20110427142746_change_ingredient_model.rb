class ChangeIngredientModel < ActiveRecord::Migration
  def self.up
    drop_table :ingredients
  
    create_table :ingredients do |t|
      t.string :recipe_id
      t.string :food_id
      
      t.timestamps
    end
    add_index :ingredients, [:recipe_id, :food_id]
  end

  def self.down
    remove_index :ingredients, :recipe_id
    
    drop_table :ingredients
    
    create_table :ingredients do |t|
      t.string :name

      t.timestamps
    end
  end
end