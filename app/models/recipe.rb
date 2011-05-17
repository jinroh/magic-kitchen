class Recipe < ActiveRecord::Base
  extend Timeline::Target
  
  after_save :save_ingredients

  belongs_to :user
  
  has_many :recipes_ingredients, :dependent => :destroy, :include => :ingredient 
  has_many :ingredients, :through => :recipes_ingredients, :source => :ingredient
  acts_as_taggable_on :tags
  
  attr_accessible :name, :content, :ingredients, :tag_list

  validates_presence_of :name, :content, :user_id
  
  timeline :verb => "added the recipe",
           :attributes => [:id, :name]
  
  def self.search(query)
    if query.to_s.blank?
      return scoped
    end
    where("#{table_name}.name LIKE ?", "%#{query.to_s}%")
  end
  
  def self.with_ingredients(ingredients, options = {})
    list = List.from(ingredients)
    return scoped if list.empty?
    
    select = "#{table_name}.*"
    joins  = []
    conditions = []
    
    if options.delete :any
      select.insert 0, "DISTINCT"
      joins  << :base_ingredients
      conditions = list.map { |name| sanitize_sql(["ingredients.name LIKE ?", name]) }.join(" OR ")
      
    elsif options.delete :exclude
      conditions = list.map { |name| sanitize_sql(["ingredients.name LIKE ?", name]) }.join(" OR ")
      conditions = "#{table_name}.id NOT IN (" +
                   "SELECT recipes_ingredients.recipe_id FROM recipes_ingredients" + 
                   "  JOIN ingredients" +
                   "    ON recipes_ingredients.ingredient_id = ingredients.id" +
                   "   AND (#{conditions})"+
                   ")"
                   
    else
      ingredients = Ingredient.named_like_any(list)

      ingredients.each do |ingredient|
        recipes_ingredients_alias = "recipes_ingredients_#{ingredient.name.gsub(/[^a-zA-Z0-9]/, "")}_#{rand(1024)}"
        joins << "JOIN #{RecipesIngredient.table_name} #{recipes_ingredients_alias}" +
                 "  ON #{recipes_ingredients_alias}.recipe_id = #{table_name}.id" +
                 " AND #{recipes_ingredients_alias}.ingredient_id = #{ingredient.id}"
      end
    end
    
    scoped :select => select,
           :joins  => joins.join(" "),
           :conditions => conditions
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end

  def ingredients=(list)
    @ingredients_list = list.map { |value| Ingredient.new(:name => value[:name]) }
  end
  
  private
  
  def save_ingredients
    return if @ingredients_list.nil?
    saved_ingredients = Ingredient.find_or_create_all_with_like_by_name(@ingredients_list.map(&:name))

    old_ingredients = ingredients - saved_ingredients
    new_ingredients = saved_ingredients - ingredients
    
    delete_ingredients(old_ingredients)
    
    new_ingredients.each do |ingredient|
       RecipesIngredient.create!(:recipe_id => self.id, :ingredient_id => ingredient.id)
    end
  end
  
  def delete_ingredients(ingredients)
    ids = ingredients.map(&:id)
    RecipesIngredient.delete_all(:recipe_id => self.id, :ingredient_id => ids) if ids.present?
  end
  
end

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

