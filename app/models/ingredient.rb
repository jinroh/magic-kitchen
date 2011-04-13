class Ingredient < ActiveRecord::Base
  
  # Asociations
  #
  has_many :favorites, :as => :favorable
  
  has_and_belongs_to_many :recipes
  
end
