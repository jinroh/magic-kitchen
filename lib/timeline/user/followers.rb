module Timeline
  module User
    module Followers
      
      def follow!(user)
        $redis.multi do
          $redis.sadd(self.following_key, user.id)
          $redis.sadd(user.followers_key, self.id)
        end
      end

      def unfollow!(user)
        $redis.multi do
          $redis.srem(self.following_key, user.id)
          $redis.srem(user.followers_key, self.id)
        end
      end
      
      def followers_ids
        @followers_ids ||= $redis.smembers(self.followers_key) || []
      end
      
      def following_ids
        @following_ids ||= $redis.smembers(self.following_key) || []
      end
      
      def friends_ids
        @friends_ids ||= $redis.sinter(self.following_key, self.followers_key) || []
      end
      
      def followers
        user_ids = self.followers_ids
        @followers ||= user_ids.empty? ? [] : self.class.where(:id => user_ids)
      end

      def following
        user_ids = self.following_ids
        @following ||= user_ids.empty? ? [] : self.class.where(:id => user_ids)
      end

      def friends
        user_ids = self.friends_ids
        @friends ||= user_ids.empty? ? [] : self.class.where(:id => user_ids)
      end

      def followed_by?(user)
        $redis.sismember(self.followers_key, user.id)
      end

      def following?(user)
        $redis.sismember(self.following_key, user.id)
      end

      def followers_count
        @followers_cout ||= $redis.scard(self.followers_key)
      end

      def following_count
        @following_cout ||= $redis.scard(self.following_key)
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