module Eventable
  def self.included(base)
    model_name = base.model_name
    Event.class_eval do
      scope model_name.downcase.pluralize.to_sym, where(:eventable_type => model_name)
    end
    
    base.send :include, Eventable::InstanceMethods
    base.class_eval do
      after_save :save_event
    end
  end

  module InstanceMethods
    private
    def save_event
      Event.add(:user_id => self.user_id, :eventable => self)
    end
  end
end