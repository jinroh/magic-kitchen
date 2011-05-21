namespace :db do
  desc "Erase and fill the database"
  task :populate => :environment do
    require "populator"
    require "forgery"
    require "redis"
    
    # redis = Redis.connect
    [User, Recipe, RecipesIngredient, Ingredient, Like, Tagging].map(&:delete_all)
    # redis.flushdb
    
    HUGE = true
    
    if HUGE == true
      USERS               = 5000
      RECIPES             = 5000
      INGREDIENTS         = 1000
      TAGS                = 100
      FOLLOWERS           = 200
    else
      USERS               = 10
      RECIPES             = 5
      INGREDIENTS         = 5
      TAGS                = 3
      FOLLOWERS           = 2
    end
    
    RECIPES_INGREDIENTS = 15 * RECIPES
    LIKES               = 50 * USERS
    TAGGINGS            = 8 * RECIPES

    # User.populate USERS do |user|
    #   user.first_name         = Forgery::Name.first_name
    #   user.last_name          = Forgery::Name.last_name
    #   user.about              = Forgery::LoremIpsum.paragraph
    #   user.encrypted_password = Forgery::Basic.encrypt
    #   user.created_at         = 2.years.ago..Time.now
    # end
    
    puts "Users done"
    
    # (1..USERS).each do |user_id|
    #   followers = Array.new(rand(FOLLOWERS) + 1).map{ rand(FOLLOWERS) + 1 }.uniq
    #   followers.each do |i|
    #     following = rand(followers.length) + 1
    #     next if following == user_id
    #     redis.multi do
    #       redis.sadd("User:#{user_id}:following", following)
    #       redis.sadd("User:#{following}:followers", user_id)
    #     end
    #   end
    # end
    
    # Ingredient.populate INGREDIENTS do |ingredient|
    #      ingredient.name = Populator.words(1..3)
    #    end
    #    
    #    puts "Ingredients done"
    #    
    #    Recipe.populate RECIPES do |recipe|
    #      recipe.name     = Populator.words(2..5)
    #      recipe.content  = Populator.paragraphs(2..4)
    #      recipe.user_id  = rand(USERS) + 1
    #    end
    
    puts "Recipes done"
    
    array = Array.new(RECIPES_INGREDIENTS).map { [rand(RECIPES) + 1, rand(INGREDIENTS) + 1] }.uniq
    array.each do |a|
      RecipesIngredient.new(:recipe_id => a[0], :ingredient_id => a[1]).save
    end
    
    puts "Recipe's ingredients done"
    
    array = Array.new(LIKES).map { [rand(USERS) + 1, rand(RECIPES) + 1] }.uniq
    array.each do |a|
      Like.new(:user_id => a[0], :recipe_id => a[1]).save
    end
    
    puts "Likes done"
    
    Tag.populate TAGS do |tag|
      tag.name = Populator.words 1
    end
    
    puts "Tags done"
    
    Tagging.populate TAGGINGS do |tagging|
      tagging.taggable_type = "Recipe"
      tagging.taggable_id   = rand(RECIPES) + 1
      tagging.tag_id        = rand(TAGS) + 1
    end
    
    puts "Taggings done"
    
  end
end