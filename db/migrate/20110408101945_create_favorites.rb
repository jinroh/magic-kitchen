class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.references :favorable, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
