# == Schema Information
#
# Table name: cookbooks
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  recipe_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Favorite < ActiveRecord::Base
  include Timeline::Target
  attr_accessible :user_id, :recipe_id
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "added to his cookbook",
           :target     => :recipe,
           :attributes => [:id, :name]
end