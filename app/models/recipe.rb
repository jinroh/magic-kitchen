# == Schema Information
#
# Table name: recipes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Recipe < ActiveRecord::Base
  extend RecipeSearch
  include Timeline::Target
  
  after_save :save_ingredients
  
  attr_accessible :name, :content, :ingredients, :tag_list

  belongs_to :user
  has_many :recipes_ingredients, :dependent => :destroy, :include => :ingredient 
  has_many :ingredients, :through => :recipes_ingredients, :source => :ingredient
  
  acts_as_taggable_on :tags
  
  validates_presence_of :name, :content, :user_id
  
  timeline :verb => "added the recipe",
           :attributes => [:id, :name]
  
  def to_param
    "#{id}-#{name.parameterize}"
  end

  def ingredients=(list)
    @ingredients_list = list.map { |value| Ingredient.new(:name => value[:name]) }
  end
  
  def score=(score)
    @score = score.to_i
  end
  
  def score
    @score
  end
  
  def serializable_hash(options={})
    opts = {:include => :ingredients, :methods => [:tag, :score, :can_edit]}
    opts.merge(options) unless options.nil?
    super(opts)
  end

  private
  def save_ingredients
    return if @ingredients_list.nil?
    saved_ingredients = Ingredient.find_or_create_all_with_like_by_name(@ingredients_list.map(&:name))

    old_ingredients = ingredients - saved_ingredients
    new_ingredients = saved_ingredients - ingredients

    delete_ingredients(old_ingredients)
    debugger
    new_ingredients.each do |ingredient|
      recipes_ingredients.create!(:ingredient_id => ingredient.id)
    end
  end
  
  def delete_ingredients(ingredients)
    ids = ingredients.map(&:id)
    RecipesIngredient.delete_all(:recipe_id => self.id, :ingredient_id => ids) if ids.present?
  end
  
end
