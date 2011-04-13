class Favorite < ActiveRecord::Base
  
  # Associations
  #
  belongs_to :favorable, :polymorphic => true
  belongs_to :user
  
  # Validations
  #
  validates_presence_of :user_id, :favorable_id, :favorable_type
  
end
