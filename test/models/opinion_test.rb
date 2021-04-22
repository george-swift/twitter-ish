require 'test_helper'

class OpinionTest < ActiveSupport::TestCase
  def setup
    @author = users(:alexa)
    @opinion = @author.opinions.build(text: "Let's run some tests")
  end

  test 'should be valid' do
    assert @opinion.valid?
  end

  test 'author id should be present' do
    @opinion.author_id = nil
    assert_not @opinion.valid?
  end

  test 'text should be present' do
    @opinion.text = '  '
    assert_not @opinion.valid?
  end

  test 'text should not be more then 140 characters' do
    @opinion.text = 'a' * 141
    assert_not @opinion.valid?
  end

  test 'list should be sorted by most recent' do
    assert_equal opinions(:most_recent), Opinion.first
  end
end
