namespace :db do
  desc "Erase and fill the database"
  task :populate => :environment do |t, args|
    require "populator"
    require "forgery"
    
    [User, Recipe, RecipesIngredient, Ingredient, Like, Favorite, Tagging].map(&:delete_all)
    
    HUGE = false
    
    if HUGE == true
      USERS = 500
      RECIPES = 5000
      INGREDIENTS = 500
      TAGS = 100
      FOLLOWERS = 200
    else
      USERS = 30
      RECIPES = 50
      INGREDIENTS = 100
      TAGS = 10
      FOLLOWERS = 10
    end
    
    # RECIPES_INGREDIENTS = 15 * RECIPES
    # LIKES = 50 * USERS
    # TAGGINGS = 8 * RECIPES

    User.populate USERS do |user|
      user.first_name = Forgery::Name.first_name
      user.last_name  = Forgery::Name.last_name
      user.email      = Forgery::Internet.email_address
      user.about      = Forgery::LoremIpsum.paragraph
      user.country    = Forgery::Address.country
      user.encrypted_password = Forgery::Basic.encrypt
      user.created_at = 2.years.ago..Time.now
    end
    puts "Users done"
    
    Ingredient.populate INGREDIENTS do |ingredient|
      ingredient.name = Populator.words(1..3)
    end
    puts "Ingredients done"
    
    Recipe.populate RECIPES do |recipe|
      recipe.name = Populator.words(2..5)
      recipe.content = Populator.paragraphs(2..4)
      recipe.user_id = rand(USERS) + 1
    end
    puts "Recipes done"
    
    Tag.populate TAGS do |tag|
      tag.name = Populator.words 1
    end
    puts "Tags done"
    
  end
  
  desc "Erase and fill the redis database with followers and following"
  task :redis => :environment do
    require "redis"
    
    redis = $redis
    redis.flushdb
    
    HUGE = false
    
    if HUGE == true
      USERS     = 999
      FOLLOWERS = 50
    else
      USERS     = 50
      FOLLOWERS = 10
    end
    
    (1..USERS).each do |user_id|
      followers = Array.new(rand(FOLLOWERS) + 1).map{ rand(USERS) + 1 }.uniq
      followers.each do |i|
        next if i == user_id
        redis.multi do
          redis.sadd("User:#{user_id}:following", i)
          redis.sadd("User:#{i}:followers", user_id)
        end
      end
      puts "#{user_id}: #{followers.length}"
    end
    
  end
end