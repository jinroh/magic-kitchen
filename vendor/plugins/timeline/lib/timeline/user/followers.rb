module Timeline
  module User
    module Followers
      
      def follow!(user)
        Timeline.redis.multi do
          Timeline.redis.sadd(self.following_key, user.id)
          Timeline.redis.sadd(user.followers_key, self.id)
        end
      end

      def unfollow!(user)
        Timeline.redis.multi do
          Timeline.redis.srem(self.following_key, user.id)
          Timeline.redis.srem(user.followers_key, self.id)
        end
      end
      
      def followers_ids
        Timeline.redis.smembers(self.followers_key) || []
      end
      
      def following_ids
        Timeline.redis.smembers(self.following_key) || []
      end
      
      def friends_ids
        Timeline.redis.sinter(self.following_key, self.followers_key) || []
      end
      
      def followers
        user_ids = self.followers_ids
        user_ids.empty? ? [] : self.class.where(:id => user_ids)
      end

      def following
        user_ids = self.following_ids
        user_ids.empty? ? [] : self.class.where(:id => user_ids)
      end

      def friends
        user_ids = self.friends_ids
        user_ids.empty? ? [] : self.class.where(:id => user_ids)
      end

      def followed_by?(user)
        user = user.is_a?(String) ? user.to_i : user.id
        Timeline.redis.sismember(self.followers_key, user)
      end

      def following?(user)
        user = user.is_a?(String) ? user.to_i : user.id
        Timeline.redis.sismember(self.following_key, user)
      end

      def followers_count
        Timeline.redis.scard(self.followers_key)
      end

      def following_count
        Timeline.redis.scard(self.following_key)
      end

      protected
      def key(str)
        "#{self.class.name}:#{self.id}:#{str}"
      end
      
      def followers_key
        @followers_key ||= key("followers")
      end
      
      def following_key
        @following_key ||= key("following")
      end
      
    end
  end
end