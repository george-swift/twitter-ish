require 'test_helper'

class OpinionsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alexa)
  end

  test 'opinions interface' do
    log_in_as(@user)
    get users_path
    assert_select 'div.user-info'
    assert_select 'section.timeline'
    assert_select 'div.field'
    # Invalid submission
    assert_no_difference 'Opinion.count' do
      post opinions_path params: { opinion: { text: ' ' } }
    end
    assert_not flash.empty?
    # Valid submission
    text = 'This test will really tie in everything done so far'
    assert_difference 'Opinion.count', 1 do
      post opinions_path params: { opinion: { text: text } }
    end
    assert_redirected_to users_url
    follow_redirect!
    assert_match text, response.body
    # Delete opinion
    assert_select 'a>img#bin'
    first_opinion = @user.opinions.first
    assert_difference 'Opinion.count', -1 do
      delete opinion_path(first_opinion)
    end
    # Delete option is not visible on other authors' tweets
    get user_path(users(:jarvis))
    assert_select 'a>img#bin', count: 0
  end

  test 'opinions count on profile info section' do
    log_in_as(@user)
    get user_path(@user)
    opinion = @user.opinions.count
    assert_select 'p.stat', "#{opinion} Tweets".pluralize(opinion)
    # Check an author with no opinions tweeted
    other_user = users(:siri)
    log_in_as(other_user)
    get user_path(other_user)
    opinion = other_user.opinions.count
    assert_select 'p.stat', "#{opinion} Tweets".pluralize(opinion)
    # Check pluralization after posting an opinion
    other_user.opinions.create!(text: 'Hey Siri')
    assert_select 'p.stat', "#{opinion} Tweets".pluralize(opinion)
  end
end
