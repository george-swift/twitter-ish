require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jarvis)
  end

  test 'log in with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path params: { session: { username: ' ' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'log in with valid information and subsequent log out' do
    get login_path
    post login_path params: { session: { username: @user.username, fullname: @user.fullname } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    delete logout_path
    assert_not user_logged_in?
    assert_redirected_to root_url
  end
end
