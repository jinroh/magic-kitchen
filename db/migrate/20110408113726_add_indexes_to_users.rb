class AddIndexesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :login, :string, :null => false, :limit => 20, :default => ""
    
    add_index :users, :login, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :firstname
    add_index :users, :lastname
    
    change_column :users, :firstname, :string, :limit => 50
    change_column :users, :lastname, :string, :limit => 50
    change_column :users, :email, :string, :null => false, :limit => 100, :default => ""
    
    rename_column :users, :lastname, :last_name
    rename_column :users, :firstname, :first_name
  end

  def self.down    
    rename_column :users, :first_name, :firstname
    rename_column :users, :last_name, :lastname
    
    change_column :users, :email, :string
    change_column :users, :lastname, :string
    change_column :users, :firstname, :string
    
    remove_index :users, :lastname
    remove_index :users, :firstname
    remove_index :users, :email
    remove_index :users, :login
    
    remove_column :users, :login
  end
end