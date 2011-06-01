module Timeline
  class Feed
    include Enumerable
    delegate :each, :to => :to_a
    
    attr_reader :name, :user, :followers, :limit, :offset
    
    LIMIT = 10
    
    def initialize(name, user, followers)
      @name, @user    = name.to_sym, user
      @limit, @offset = LIMIT, 0
      self.followers  = followers
    end
    
    def empty?
      Timeline.redis.lindex(key, 0).nil?
    end
    
    def all
      to_a
    end
    
    def to_a
      @events ||= Timeline.redis.lrange(key, @offset, (@offset + @limit)-1).map { |data| Timeline::Event.from(data) }
    end
    
    def count
      Timeline.redis.llen(key)
    end
    
    def destroy
      Timeline.redis.del(key)
    end
    
    def limit(int)
      @limit = int.to_i
      self
    end
    
    def offset(int)
      @offset = int.to_i
      self
    end
    
    def key
      @key ||= (@followers == :all) ? self.class.key(@name, "all") : self.class.key(@name, @user.id)
    end
    
    def self.key(feed_name, user_id)
      "Feed:#{feed_name.to_s}:User:#{user_id.to_s}"
    end
    
    def to_json(options={})
      [].tap do |array|
        each do |event|
          array << event.to_json
        end
      end.to_json
    end
    
    private
    def followers=(followers)
      @followers = case followers
      when :all, nil
        :all
      when :self
        [@user.id]
      when String, Symbol
        array = user.send(followers)
        raise ArgumentError, "wrong argument :followers" unless array.is_a?(Array)
        array
      else
        raise ArgumentError, "wrong argument :followers"
      end
    end
  end
end