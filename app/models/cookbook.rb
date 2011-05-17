class Cookbook < ActiveRecord::Base
  extend Timeline::Target
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "added to his cookbook",
           :target     => :recipe,
           :attributes => [:id, :name]
end
