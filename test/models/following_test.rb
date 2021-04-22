require 'test_helper'

class FollowingTest < ActiveSupport::TestCase
  def setup
    @following = Following.new(follower_id: users(:jarvis).id, followed_id: users(:alexa).id)
  end

  test 'should be valid' do
    assert @following.valid?
  end

  test 'should require a follower_id' do
    @following.follower_id = nil
    assert_not @following.valid?
  end

  test 'should require a followed_id' do
    @following.followed_id = nil
    assert_not @following.valid?
  end
end
