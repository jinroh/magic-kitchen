require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: recipes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

