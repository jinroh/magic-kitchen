class Favorite < ActiveRecord::Base
  
  # Associations
  #
  belongs_to :favorable, :polymorphic => true
  belongs_to :user
  
  # Validations
  #
  validates_presence_of :user_id, :favorable_id, :favorable_type
  
end

# == Schema Information
#
# Table name: favorites
#
#  id             :integer         not null, primary key
#  favorable_id   :integer
#  favorable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

