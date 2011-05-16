class CreateCookbooks < ActiveRecord::Migration
  def self.up
    create_table :cookbooks do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cookbooks
  end
end
