class ChangeNameCookbooks < ActiveRecord::Migration
  def self.up
    drop_table :favorites
    rename_table :cookbooks, :favorites
  end

  def self.down
    rename_table :favorites, :cookbooks
  end
end