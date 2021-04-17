require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_template 'users/new'
    assert_select 'input[type=file]'
    assert_no_difference 'User.count' do
      post users_path params: { user: { fullname: ' ', username: 'a' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    get signup_path
    assert_select 'input[type=file]'
    assert_difference 'User.count', 1 do
      post users_path params: { user: { fullname: 'ai jarvis', username: 'jarvis' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:warning]
    assert flash[:success]
  end
end
