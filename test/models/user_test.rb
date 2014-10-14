require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validations are correct' do
    user = User.new
    user.valid?
    assert_not user.valid?

    user = User.new(username: 'Fred')
    assert_not user.valid?

    user = User.new(username: 'Fred', password: '123456789')
    assert user.valid?
  end
end
