class History < ActiveRecord::Base
  extend Timeline::Target
  
  belongs_to :user
  belongs_to :recipe
  
  timeline :verb => "has done the recipe",
           :target     => :recipe,
           :attributes => [:id, :name]
end
