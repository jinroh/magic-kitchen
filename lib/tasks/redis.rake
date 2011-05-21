namespace :db do
  task :redis => :environment do
    require "redis"
    
    redis = Redis.connect
    redis.flushdb
    
    HUGE = false
    
    if HUGE == true
      USERS     = 5000
      FOLLOWERS = 300
    else
      USERS     = 50
      FOLLOWERS = 10
    end
    
    (1..USERS).each do |user_id|
      followers = Array.new(rand(FOLLOWERS) + 1).map{ rand(FOLLOWERS) + 1 }.uniq
      followers.each do |i|
        # following = rand(followers.length) + 1
        next if i == user_id
        redis.multi do
          redis.sadd("User:#{user_id}:following", i)
          redis.sadd("User:#{i}:followers", user_id)
        end
      end
    end
    
  end
end