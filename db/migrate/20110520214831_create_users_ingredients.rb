class CreateUsersIngredients < ActiveRecord::Migration
  def self.up
    create_table :users_ingredients, :id => false do |t|
      t.integer :user_id, :primary_key
      t.integer :ingredient_id, :primary_key
      t.integer :weight
      t.float :coeff

      t.timestamps
    end
    add_index :users_ingredients, :user_id
  end

  def self.down
    remove_index :users_ingredients, :user_id
    drop_table :users_ingredients
  end
end