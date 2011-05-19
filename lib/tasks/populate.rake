namespace :db do
  desc "Erase and fill the database"
  task :populate => :environment do
    require "populator"
    require "forgery"
    require "redis"
    
    [User, Recipe, RecipesIngredient, Ingredient, Like, Cookbook, Tagging].map(&:delete_all)
    
    USERS               = 500
    RECIPES             = 300
    INGREDIENTS         = 50
    TAGS                = 100
    RECIPES_INGREDIENTS = 3 * RECIPES
    LIKES               = 6 * USERS
    
    User.populate USERS do |user|
      user.first_name         = Forgery::Name.first_name
      user.last_name          = Forgery::Name.last_name
      user.email              = Forgery::Internet.email_address
      user.about              = Forgery::LoremIpsum.paragraph
      user.encrypted_password = Forgery::Basic.encrypt
      user.created_at         = 2.years.ago..Time.now
    end
    
    Ingredient.populate INGREDIENTS do |ingredient|
      ingredient.name = Populator.words(1..3)
    end
    
    Recipe.populate RECIPES do |recipe|
      recipe.name     = Populator.words(2..5)
      recipe.content  = Populator.paragraphs(2..4)
    end
    
    RecipesIngredient.populate RECIPES_INGREDIENTS do |assoc|
      assoc.recipe_id = rand RECIPES
      assoc.ingredient_id = rand INGREDIENTS
    end
    
    Like.populate LIKES do |like|
      like.user_id   = rand USER
      like.recipe_id = rand RECIPES
    end
    
    Tag.populate do |tag|
      tag.name = Populator.words 1
    end
    
    Tagging.populate do |tagging|
      tagging.taggable_type = "Recipe"
      tagging.taggable_id   = rand RECIPES
      tagging.tag_id        = rand TAGS
    end
    
  end
end