class History < ActiveRecord::Base
  include Eventable
  
  belongs_to :user
  belongs_to :recipe
end
