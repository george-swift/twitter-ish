require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jarvis)
    @other_user = users(:alexa)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end

  test 'should redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as a wrong user' do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to @other_user
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user, params: { user: { username: @user.username,
                                             fullname: @user.fullname } })
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when logged in as a wrong user' do
    log_in_as(@other_user)
    patch user_path(@user, params: { user: { username: @user.username,
                                             fullname: @user.fullname } })
    assert flash.empty?
    assert_redirected_to @other_user
  end

  test 'should redirect from following page when not logged in' do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test 'should redirect from followers page when not logged in' do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
