# == Schema Information
#
# Table name: cookbooks
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  recipe_id  :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Cookbook < ActiveRecord::Base
  extend Timeline::Target
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "added to his cookbook",
           :target     => :recipe,
           :attributes => [:id, :name]
end
