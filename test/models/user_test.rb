require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validations are correct' do
    user = User.new
    assert_not user.valid?

    user = User.new(username: 'Fred')
    assert user.valid?
  end
end
