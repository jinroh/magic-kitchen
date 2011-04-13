class AddBirthdayToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :birthdate, :datetime
  end

  def self.down
    remove_column :users, :birthdate
  end
end
