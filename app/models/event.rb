class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :eventable, :polymorphic => true 
  
  default_scope :order => "events.created_at DESC", :limit => 10
  
  validates_presence_of :user_id, :eventable_type, :eventable_id
  
  def self.add(hash)
    new(hash).save!
  end
end
