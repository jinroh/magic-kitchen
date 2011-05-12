class CreateActionNodes < ActiveRecord::Migration
  def self.up
    create_table :action_nodes do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.string :action
      t.integer :action_id

      t.timestamps
    end
  end

  def self.down
    drop_table :action_nodes
  end
end
