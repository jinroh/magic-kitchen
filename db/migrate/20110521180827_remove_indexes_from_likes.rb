class RemoveIndexesFromLikes < ActiveRecord::Migration
  def self.up
    add_index :likes, [:user_id, :recipe_id], :unique => false
  end

  def self.down
  end
end
