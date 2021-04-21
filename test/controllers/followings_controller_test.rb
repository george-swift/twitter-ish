require 'test_helper'

class FollowingsControllerTest < ActionDispatch::IntegrationTest
  test 'following a user should require a logged-in user' do
    assert_no_difference 'Following.count' do
      post followings_path
    end
    assert_redirected_to login_url
  end

  test 'destroy should require logged-in user' do
    assert_no_difference 'Following.count' do
      delete following_path(followings(:one))
    end
    assert_redirected_to login_url
  end
end
