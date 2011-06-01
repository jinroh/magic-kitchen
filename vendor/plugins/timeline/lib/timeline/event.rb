require "json"
require "ostruct"

module Timeline
  class Event
    include ActionView::Helpers::DateHelper
    
    TARGET_ATTRIBUTES = [:id, :name, "class.name", :created_at]
    USER_ATTRIBUTES   = [:id, :name]
    
    attr_reader :user, :verb, :target, :target_type, :time
    
    def self.from(data)
      new :data => data
    end
    
    def initialize(options = {})
      if options.has_key?(:data)
        @json = JSON.parse(options[:data], :symbolize_names => true)
        @user   = OpenStruct.new(@json[:user])
        @verb   = @json[:verb]
        @target = OpenStruct.new(@json[:target])
        @target_type = @json[:target_type]
        @time   = @json[:time]
      else
        @bind = options[:bind]
        raise ArgumentError, "no binding" if @bind.nil?
        
        self.user   = options[:user]
        self.verb   = options[:verb]
        self.target = options[:target]
        
        @target_attributes = options[:attributes] || TARGET_ATTRIBUTES
        @user_attributes   = options[:user_attributes] || USER_ATTRIBUTES
        
        @time = time_ago_in_words(DateTime.now.utc)
      end
    end
    
    def to_json
      @json ||= {
        :user   => @user.serializable_hash(:methods => @user_attributes, :include => {}, :only => {}), 
        :verb   => @verb,
        :target => @target.serializable_hash(:methods => @target_attributes, :include => {}, :only => {}),
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
      @verb = object.to_s
    end
    
  end
end