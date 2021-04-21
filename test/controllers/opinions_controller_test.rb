require 'test_helper'

class OpinionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @opinion = opinions(:rails)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Opinion.count' do
      post opinions_path params: { opinion: { content: 'Lorem ipsum' } }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Opinion.count' do
      delete opinion_path(@opinion)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy for wrong opinion' do
    log_in_as(users(:jarvis))
    opinion = opinions(:devs)
    assert_no_difference 'Opinion.count' do
      delete opinion_path(opinion)
    end
    assert_redirected_to users_url
  end
end
