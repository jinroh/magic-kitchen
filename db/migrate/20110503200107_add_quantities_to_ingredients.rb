class AddQuantitiesToIngredients < ActiveRecord::Migration
  def self.up
    add_column :recipes_ingredients, :quantity, :string
  end

  def self.down
    remove_column :recipes_ingredients, :quantity
  end
end