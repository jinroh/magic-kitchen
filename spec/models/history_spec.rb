# == Schema Information
#
# Table name: histories
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  recipe_id  :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe History do
  pending "add some examples to (or delete) #{__FILE__}"
end
