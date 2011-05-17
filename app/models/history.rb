# == Schema Information
#
# Table name: histories
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  recipe_id  :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class History < ActiveRecord::Base
  extend Timeline::Target
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "has done the recipe",
           :target     => :recipe,
           :attributes => [:id, :name]
end
