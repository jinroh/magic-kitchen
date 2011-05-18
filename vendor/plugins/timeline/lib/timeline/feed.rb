module Timeline
  class Feed
    attr_reader :name, :user, :followers, :limit, :offset
    
    def initialize(name, user, followers)
      @name, @user, @limit, @offset = name.to_sym, user, 10, 0
      self.followers = followers
    end
    
    def each(limit=@limit, offset=@offset)
      raise LocalJumpError, "no block given" unless block_given?
      (offset..(offset+limit)).each do |e|
        data = Timeline.redis.lindex(self.key, e)
        next if data.nil?
        yield Timeline::Event.from(data)
      end
    end
    
    def empty?
      Timeline.redis.lrange(self.key, 0, 0).blank?
    end
    
    def all
      to_a
    end
    
    def to_a
      Timeline.redis.lrange(key, @offset, @offset + @limit).map { |data| Timeline::Event.from(data) }
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