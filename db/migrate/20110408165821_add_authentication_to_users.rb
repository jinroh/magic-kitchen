class AddAuthenticationToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      # Database Authenticable (salt not required anymore)
      t.string        :encrypted_password,  :null => false, :default => '', :limit => 128
      # t.string        :password_salt,       :null => false, :default => ''
      
      # t.trackable
      t.recoverable
      t.rememberable
    end
    
    add_index :users, :reset_password_token
  end

  def self.down
    remove_index :users, :reset_password_token
    
    remove_column :users, :remember_created_at
    remove_column :users, :reset_password_token
    
    # Trackable
    # remove_column :users, :current_sign_in_at
    # remove_column :users, :last_sign_in_at
    # remove_column :users, :current_sign_in_ip
    # remove_column :users, :last_sign_in_ip
    # remove_column :users, :sign_in_count
    
    # remove_column :users, :password_salt
    remove_column :users, :encrypted_password
    end
end