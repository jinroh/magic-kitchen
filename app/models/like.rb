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
  include Timeline::Target
  attr_accessible :user_id, :recipe_id
  
  after_save :update_users_ingredients
  
  default_scope :order => "likes.created_at DESC", :limit => 10
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "likes",
           :target     => :recipe,
           :attributes => [:id, :name]
  

  validates_presence_of   :user_id, :recipe_id
  validates_uniqueness_of :user_id, :scope => [:recipe_id]
  
  protected
  def update_users_ingredients
    # TODO
    # RAKETASK
  end
end
