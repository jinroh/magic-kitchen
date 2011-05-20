module Timeline
  module Redis
    
    def redis=(server)
      case server
        when String
          host, port, db = server.split(':')
          @redis = ::Redis.new(:host => host, :port => port, :thread_safe => true, :db => db)
        when ::Redis
          @redis = server
        else
          raise "I don't know what to do with #{server.inspect}"
      end
    end

    def redis
      return @redis if @redis
      # self.redis = '192.168.0.69:6379'
      self.redis = "localhost:6379"
      self.redis
    end
  
  end
end
