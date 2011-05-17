module Timeline
  module Target
    
    def timeline(args = {})
      callback    = (args.delete(:when) || :after_save).to_sym
      method_name = "timeline_target_#{callback.to_s}"

      class_eval do
        private
        def update_feeds(event)
          self.user.all_feeds.each do |feed_name|
            feed = self.user.send(feed_name)
            if feed.followers == :all
              push(key(feed_name, "all"), event)
            else
              Timeline.redis.multi do
                feed.followers.each do |follower_id|
                  push(key(feed_name, follower_id), event)
                end
              end
            end
          end
        end

        def push(key, event)
          Timeline.redis.lpush(key, event.to_json)
        end
        
        def key(feed_name, user_id)
          Timeline::Feed.key(feed_name, user_id)
        end

      end
      
      define_method method_name do
        args.merge!({ :bind => self })
        event = Timeline::Event.new(args)
        update_feeds(event)
      end
      send(callback, method_name)
    end
    
  end
end