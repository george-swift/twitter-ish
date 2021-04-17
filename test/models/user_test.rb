require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'example', fullname: 'Example User')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = ' '
    assert_not @user.valid?
  end

  test 'username must be at least two characters' do
    @user.username = 'a'
    assert_not @user.valid?
  end

  test 'fullname should be present' do
    @user.fullname = ' '
    assert_not @user.valid?
  end

  test 'fullname must be at least three characters' do
    @user.fullname = 'a' * 2
    assert_not @user.valid?
  end
end
