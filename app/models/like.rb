# == Schema Information
#
# Table name: likes
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Like < ActiveRecord::Base
  extend Timeline::Target
  
  attr_accessible :recipe_id
  
  scope :by,  lambda { |user|   where(:user_id   => user) }
  scope :for, lambda { |recipe| where(:recipe_id => recipe) }
  default_scope :order => "likes.created_at DESC", :limit => 10
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "likes",
           :target     => :recipe,
           :attributes => [:id, :name]
           
  def self.current_user_create_like
    
  end
end
