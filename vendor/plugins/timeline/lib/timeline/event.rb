require "json"
require "ostruct"

module Timeline
  class Event
    TARGET_ATTRIBUTES = [:id, :name, "class.name", :created_at]
    USER_ATTRIBUTES   = [:id, :name]
    
    attr_reader :user, :verb, :target, :target_type, :time
    
    def self.from(data)
      new :data => data
    end
    
    def initialize(options = {})
      if options[:data]
        @json = options[:data]
        data = JSON.parse(options[:data], :symbolize_names => true)
        
        @user   = OpenStruct.new(data[:user])
        @verb   = data[:verb]
        @target = OpenStruct.new(data[:target])
        @target_type = data[:target_type]
        @time   = data[:time]
      else
        @bind = options[:bind]
        raise ArgumentError, "no binding" if @bind.nil?
        
        self.user   = options[:user]
        self.verb   = options[:verb]
        self.target = options[:target]
        
        @target_attributes = options[:attributes] || TARGET_ATTRIBUTES
        @user_attributes   = options[:user_attributes] || USER_ATTRIBUTES
        
        @time = @target.created_at || DateTime.now.utc
      end
    end
    
    def to_json
      @json ||= {
        :user   => @user.serializable_hash(:methods => @user_attributes, :only => {}), 
        :verb   => @verb,
        :target => @target.serializable_hash(:methods => @target_attributes, :only => {}),
        :target_type => @target_type,
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
          nil
      end
      raise ArgumentError, "doesn't know what to do with :user argument: #{object}" if @user.nil?
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
          nil
      end
      raise ArgumentError, "doesn't know what to do with :target argument: #{object}" if @target.nil?
      @target_type = @target.class.name
    end
    
    def verb=(object)
      @verb = object || @bind.class.name
      @verb = @verb.to_s
    end
    
  end
end