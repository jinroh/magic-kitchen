class AddDetailsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.datetime  :date_of_birth
      t.text      :about
      t.string    :gender,    :limit => 1,  :default => 'N'     # M, F, N
      t.string    :homepage,  :limit => 100
      t.string    :country,   :limit => 50
    end
  end

  def self.down    
    change_table :users do |t|    
      t.remove :country 
      t.remove :homepage 
      t.remove :gender 
      t.remove :about 
      t.remove :date_of_birth
    end
    
  end
end