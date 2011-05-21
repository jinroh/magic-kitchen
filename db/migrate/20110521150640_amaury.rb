class Amaury < ActiveRecord::Migration
  def self.up
    drop_table :ingredients_recipes
    
    create_table :users_ingredients, :force => true do |t|
      t.integer :user_id
      t.integer :ingredient_id
      t.integer :weight
      t.float   :coeff
    end
    
    change_table :recipes_ingredients do |t|
      t.change :recipe_id, :integer
      t.change :ingredient_id, :integer
    end

    add_index :users_ingredients, [:user_id, :ingredient_id], :unique => true
    add_index :likes, [:user_id, :recipe_id], :unique => true
    add_index :recipes_ingredients, [:recipe_id, :ingredient_id], :unique => true
  end

  def self.down
    drop_table :users_ingredients
    
    change_table :recipes_ingredients do |t|
      t.change :recipe_id, :string
      t.change :ingredient_id, :string
    end
    
    remove_index :recipes_ingredients, :column => [:recipe_id, :ingredient_id]
    remove_index :likes, :column => [:user_id, :recipe_id]
    remove_index :users_ingredients, :column => [:user_id, :ingredient_id]
  end
end