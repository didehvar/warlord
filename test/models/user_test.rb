require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'Example', email: 'user@example.com',
                     password: 'password', password_confirmation: 'password')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'username should be between 3 and 20 characters' do
    @user.username = 'a' * 2
    assert_not @user.valid?, 'Username can be less than 3 characters'

    @user.username = 'a' * 21
    assert_not @user.valid?, 'Username can be more than 20 characters'
  end

  test 'username validation should accept valid usernames' do
    valid_usernames = %w[dan jimmy freddrick SamWiseGamgee lord_of_all]
    valid_usernames.each do |username|
      @user.username = username
      assert @user.valid?
    end
  end

  test 'username validation should reject invalid usernames' do
    invalid_usernames = %w[b.o.b ji-mmy fR#edders sam%wise lord/of:all]
    invalid_usernames.each do |username|
      @user.username = username
      assert_not @user.valid?
    end
  end

  test 'username should be unique' do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.upcase
    duplicate_user.email = 'bob@example.com'

    @user.save

    assert_not duplicate_user.valid?
  end

  test 'usernames should be saved as lowercase' do
    username = 'SaMWISEGamGeE'
    @user.username = username
    @user.save

    assert_equal username.downcase, @user.reload.username
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com user@foo.COM u_se-r@foo.bar.org
                         first.last@domain.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@foo..com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.reverse
    duplicate_user.email = @user.email.upcase

    @user.save

    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lowercase' do
    email = 'FoO@eXamPLE.cOM'
    @user.email = email
    @user.save

    assert_equal email.downcase, @user.reload.email
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end
end
