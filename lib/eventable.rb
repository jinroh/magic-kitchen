module Eventable
  def self.included(base)
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