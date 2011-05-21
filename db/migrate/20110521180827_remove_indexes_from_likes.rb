class RemoveIndexesFromLikes < ActiveRecord::Migration
  def self.up
    remove_index :likes, :user_id_and_recipe_id
    add_index :likes, [:user_id, :recipe_id], :unique => false
  end

  def self.down
  end
end
