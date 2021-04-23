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

  test 'should follow and unfollow a user' do
    siri = users(:siri)
    jarvis = users(:jarvis)
    assert_not siri.following?(jarvis)
    siri.follow(jarvis)
    assert siri.following?(jarvis)
    assert jarvis.followers.include?(siri)
    siri.unfollow(jarvis)
    assert_not siri.following?(jarvis)
  end

  test 'timeline should have the right posts' do
    jarvis = users(:jarvis)
    alexa = users(:alexa)
    siri = users(:siri)
    siri.opinions.each do |opinion|
      assert jarvis.timeline.include?(opinion)
    end
    jarvis.opinions.each do |self_opinion|
      assert jarvis.timeline.include?(self_opinion)
    end
    alexa.opinions.each do |not_followed|
      assert_not jarvis.timeline.include?(not_followed)
    end
  end
end
