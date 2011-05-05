require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: favorites
#
#  id             :integer         not null, primary key
#  favorable_id   :integer
#  favorable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

