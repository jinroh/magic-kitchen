module Timeline
  module Redis
    
    def redis=(server)
      host, port, db = server.split(':')
      @redis = ::Redis.new(:host => host, :port => port, :thread_safe => true, :db => db)
    end

    def redis
      return $redis if $redis
      debugger
      return @redis if @redis
      
      self.redis = "localhost:6379"
      self.redis
    end
  
  end
end
