namespace :db do
  task :redis => :environment do
    require "redis"
    
    redis = Redis.connect
    redis.flushdb
    
    HUGE = true
    
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