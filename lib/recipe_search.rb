module RecipeSearch
  
  def with_ingredients(ingredients, options = {})
    list = List.from(ingredients)
    return scoped if list.empty?

    select = "#{table_name}.*"
    joins  = []
    conditions = []

    if options.delete :any
      select.insert 0, "DISTINCT "
      joins  << :base_ingredients
      conditions = list.map { |name| sanitize_sql(["ingredients.name LIKE ?", name]) }.join(" OR ")

    elsif options.delete :exclude
      conditions = list.map { |name| sanitize_sql(["ingredients.name LIKE ?", name]) }.join(" OR ")
      conditions = "#{table_name}.id NOT IN (" +
                   "SELECT recipes_ingredients.recipe_id FROM recipes_ingredients" + 
                   "  JOIN ingredients" +
                   "    ON recipes_ingredients.ingredient_id = ingredients.id" +
                   "   AND (#{conditions})" +
                   ")"

    else
      ingredients = Ingredient.named_like_any(list)
      return scoped(:conditions => "1=0") if ingredients.empty? # ugly empty scope
      
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
  
  def search_ingredients(options={})
    with    = List.from(options.delete(:with))
    without = List.from(options.delete(:without))
    return scoped if (with.empty? && without.empty?)
    
    with    = Ingredient.named_like_any(with)    unless with.empty?
    without = Ingredient.named_like_any(without) unless without.empty?
    
    conditions = "SELECT * FROM recipes INNER JOIN" + 
                 " (SELECT B.recipe_id, C ,number FROM" +
                 " (SELECT recipe_id , COUNT(ingredient_id) AS C FROM recipes_ingredients WHERE"+
                 " ingredient_id IN (" + with.map(&:id) + ") AND recipe_id NOT IN" +
                 " (SELECT recipe_id FROM recipes_ingredients WHERE" +
                 " ingredient_id IN ("+ without.map(&:id) + "))" +
                 " GROUP BY recipe_id ORDER BY C DESC)" +
                 " AS A INNER JOIN like_number AS B ON A.recipe_id=B.recipe_id" +
                 " ORDER BY C DESC,number DESC LIMIT 20) AS E ON recipes.id=E.recipe_id"
  end
  
  def search(query)
    if query.to_s.blank?
      return scoped
    end
    where("#{table_name}.name LIKE ?", "%#{query.to_s}%")
  end
  
end