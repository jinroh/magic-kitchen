require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  first_name           :string(50)
#  last_name            :string(50)
#  email                :string(100)     default(""), not null
#  created_at           :datetime
#  updated_at           :datetime
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_created_at  :datetime
#  login                :string(20)      default(""), not null
#  date_of_birth        :datetime
#  about                :text
#  gender               :string(1)       default("N")
#  homepage             :string(100)
#  country              :string(50)
#

