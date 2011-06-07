module Timeline
  module User

    def timelined?
      false
    end
  
    def timeline(feed_name, followers)
      raise ArgumentError, "#{self.class.name}\##{feed_name} method already defined" if self.respond_to?(feed_name.to_sym)
    
      if timelined?
        write_inheritable_attribute(:all_feeds, (self.all_feeds << feed_name.to_sym))
      else
        write_inheritable_attribute(:all_feeds, [feed_name.to_sym])
        class_inheritable_accessor(:all_feeds)
      
        class_eval do
          def self.timelined?
            true
          end
        end
      end
      
      define_method feed_name.to_sym do
        variable = "@timeline_#{feed_name}"
        instance_variable_get(variable) || instance_variable_set(variable, Timeline::Feed.new(feed_name, self, followers))
      end
      
      after_destroy "delete_user_timeline_#{feed_name}"
      private
      define_method "delete_user_timeline_#{feed_name}" do
        self.all_feeds.each do |feed_name|
          send(feed_name).destroy
        end
      end
    end
    
  end
end
