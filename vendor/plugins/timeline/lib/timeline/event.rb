require "json"

module Timeline
  class Event
    attr_reader :user, :verb, :target, :time
    
    def self.from(data)
      new :data => data
    end
    
    def initialize(options = {})
      if options[:data]
        @json = options[:data]
        data = JSON.parse(options[:data], :symbolize_names => true)
        @user = data[:user]
        @verb = data[:verb]
        @target = data[:target]
      else
        @bind = options[:bind]
        raise ArgumentError, "no binding" if @bind.nil?
        
        self.user   = options[:user]
        self.verb   = options[:verb]
        self.target = options[:target]
        
        @target_attributes = options[:attributes] || [:id, :name]
        @user_attributes   = options[:user_attributes] || [:id, :name]
        
        @time = @target.created_at || DateTime.now.utc
      end
    end
    
    def to_json
      @json ||= {
        :user   => @user.serializable_hash(:methods => @user_attributes, :only => {}), 
        :verb   => @verb,
        :target => @target.serializable_hash(:methods => @target_attributes, :only => {}),
        :time   => @time.to_s
      }.to_json
    end
    
    protected
    def user=(object)
      @user = case object
        when ActiveRecord::Base
          object
        when String, Symbol
          @bind.send(object)
        when Proc
          @bind.instance_eval(&object)
        when nil
          @bind.send(:user)
        else
          raise ArgumentError, "doesn't know what to do with :user argument: #{object}"
      end
    end
    
    def target=(object)
      @target = case object
        when nil, :self
          @bind
        when ActiveRecord::Base
          object
        when String, Symbol
          @bind.send(object)
        when Proc
          @bind.instance_eval(&object)
        else
          raise ArgumentError, "doesn't know what to do with :user argument: #{object}"
      end
    end
    
    def verb=(object)
      @verb = object || @bind.class.name
      @verb = @verb.to_s
    end
    
  end
end