# == Schema Information
#
# Table name: ingredients
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ingredient < ActiveRecord::Base
  
  attr_accessible :name, :quantity
  
  has_many :recipes_ingredients, :dependent => :destroy, :include => :quantity
  
  validates_uniqueness_of :name, :with => { :case_sensitive => false }
  validates_presence_of :name
  
  before_save :clean_name
  
  def self.named(name)
    where(["name LIKE ?", name])
  end
  
  def self.named_like(name)
    where(["name LIKE ?", "%#{name}%"])
  end
  
  def self.named_any(list)
    where(list.map { |name| sanitize_sql(["name LIKE ?", name.to_s]) }.join(" OR "))
  end
  
  def self.named_like_any(list)
    where(list.map { |name| sanitize_sql(["name LIKE ?", "%#{name.to_s}%"]) }.join(" OR "))
  end
  
  def self.find_or_create_with_like_by_name(name)
    named_like(name) || create(:name => name)
  end
  
  def self.find_or_create_all_with_like_by_name(list)
    list = [list].flatten.delete_if(&:blank?)
    
    return [] if list.empty?
    
    existing_ingredient_names = Ingredient.named_any(list).all
    new_ingredient_names      = list.reject do |name|
      existing_ingredient_names.any? { |ingredient| ingredient.to_s.downcase == name.to_s.downcase }
    end
    new_ingredient_names.map! { |name| create(:name => name) }
    
    existing_ingredient_names + new_ingredient_names
  end
  
  def ==(object)
    (object.is_a?(Ingredient) && name == object.name)
  end
  
  def to_s
    name
  end
  
  private
  def clean_name
    self.name = name.strip
                    .downcase
                    .squeeze(" ")
  end
  
end