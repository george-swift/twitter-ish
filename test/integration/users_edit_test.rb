require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jarvis)
  end

  test "a user profile's unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user, params: { user: { username: 'j',
                                             fullname: 'jv' } })
    assert_template 'users/edit'
    assert_select 'div.alert'
  end

  test 'a successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    username = 'alexa'
    fullname = 'amazon alexa'
    patch user_path(@user, params: { user: { username: username,
                                             fullname: fullname } })
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username, @user.username
    assert_equal fullname, @user.fullname
  end
end
