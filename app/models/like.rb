class Like < ActiveRecord::Base
  include Eventable
  
  scope :by, lambda { |user| where(:user_id => user.id) } 
  default_scope :order => "likes.created_at DESC" ,:limit => 10
  
  belongs_to :user
  belongs_to :recipe
end
