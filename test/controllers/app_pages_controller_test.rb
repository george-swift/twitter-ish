require "test_helper"

class AppPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get app_pages_home_url
    assert_response :success
  end

  test "should get about" do
    get app_pages_about_url
    assert_response :success
  end
end
