namespace :db do
  desc "Erase and fill the database"
  task :populate => :environment do
    require "populator"
    require "forgery"
    require "redis"
    
    redis = Redis.connect
    
    [User, Recipe, RecipesIngredient, Ingredient, Like, Cookbook, Tagging].map(&:delete_all)
    redis.flushdb
    
    HUGE = false
    
    if HUGE == true
      USERS               = 500
      RECIPES             = 300
      INGREDIENTS         = 50
      TAGS                = 100
      FOLLOWERS           = 30
    else
      USERS               = 10
      RECIPES             = 5
      INGREDIENTS         = 5
      TAGS                = 3
      FOLLOWERS           = 2
    end
    
    RECIPES_INGREDIENTS = 3 * RECIPES
    LIKES               = 6 * USERS
    TAGGINGS            = 6 * RECIPES

    User.populate USERS do |user|
      user.first_name         = Forgery::Name.first_name
      user.last_name          = Forgery::Name.last_name
      user.email              = Forgery::Internet.email_address
      user.about              = Forgery::LoremIpsum.paragraph
      user.encrypted_password = Forgery::Basic.encrypt
      user.created_at         = 2.years.ago..Time.now
    end
    
    (1..USERS).each do |user_id|
      nb_followers = 
      followers = Array.new(rand(FOLLOWERS) + 1).map{ rand(FOLLOWERS) + 1 }.uniq
      followers.each do |i|
        following = rand(nb_followers) + 1
        next if following == user_id
        redis.multi do
          redis.sadd("User:#{user_id}:following", following)
          redis.sadd("User:#{following}:followers", user_id)
        end
      end
    end
    
    Ingredient.populate INGREDIENTS do |ingredient|
      ingredient.name = Populator.words(1..3)
    end
    
    Recipe.populate RECIPES do |recipe|
      recipe.name     = Populator.words(2..5)
      recipe.content  = Populator.paragraphs(2..4)
      recipe.user_id  = rand(USERS) + 1
    end
    
    RecipesIngredient.populate RECIPES_INGREDIENTS do |assoc|
      assoc.recipe_id = rand(RECIPES) + 1
      assoc.ingredient_id = rand(INGREDIENTS) + 1
    end
    
    Like.populate LIKES do |like|
      like.user_id   = rand(USERS) + 1
      like.recipe_id = rand(RECIPES) + 1
    end
    
    Tag.populate TAGS do |tag|
      tag.name = Populator.words 1
    end
    
    Tagging.populate TAGGINGS do |tagging|
      tagging.taggable_type = "Recipe"
      tagging.taggable_id   = rand(RECIPES) + 1
      tagging.tag_id        = rand(TAGS) + 1
    end
    
  end
end