class Recipe < ActiveRecord::Base
  attr_accessible :name, :content
  # Associations
  #
  belongs_to :user
  has_many :favorites, :as => :favorable
  
  has_and_belongs_to_many :ingredients
  
  # Validations
  #
  validates :name,    :presence => true
  validates :content, :presence => true
  
  def creator
    user
  end
  
  def creator?(user)
    creator==user
  end

end
