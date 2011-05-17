require "json"

module Timeline
  class Event
    attr_reader :user, :verb, :target
    
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
        @target_attributes = options[:attributes]      || [:id, :name]
        @user_attributes   = options[:user_attributes] || [:id, :name]
        raise ArgumentError, "no binding" if @bind.nil?
        self.user   = options[:user]
        self.verb   = options[:verb]
        self.target = options[:target]
      end
    end
    
    def to_s
      [@user[:name], @verb, @target[:name]].join(' ').to_s
    end
    
    def to_json
      @json ||= {
        :user   => @user.serializable_hash(:methods => @user_attributes, :only => {}), 
        :verb   => @verb,
        :target => @target.serializable_hash(:methods => @target_attributes, :only => {})
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
        when ActiveRecord::Base
          object
        when String, Symbol
          @bind.send(object)
        when Proc
          @bind.instance_eval(&object)
        when nil
          @bind
        else
          raise ArgumentError, "doesn't know what to do with :user argument: #{object}"
      end
    end
    
    def verb=(object)
      @verb = object || @bind.class.name
      @verb = @verb.to_s.downcase
    end
    
  end
end