require 'rails_helper'

RSpec.describe Following, type: :model do
  fixtures :users

  let(:jarvis) { users(:jarvis) }
  let(:siri) { users(:siri) }

  subject(:following) { Following.new(follower_id: users(:jarvis).id, followed_id: users(:siri).id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(following).to be_valid
    end

    it 'is not valid without a follower_id' do
      following.follower_id = nil
      expect(following).to_not be_valid
    end

    it 'is not valid without a followed_id' do
      following.followed_id = nil
      expect(following).to_not be_valid
    end
  end

  describe '#follow' do
    context 'timeline should include tweets of followed users' do
      before do
        siri.opinions.create(text: 'Testing with Rspec')
      end

      it 'should only have tweets from self before any following' do
        expect(siri.timeline.size).to eq(1)
      end

      it 'should have tweets from self and followed user' do
        siri.follow(jarvis)
        expect(siri.timeline.size).to eq(5)
      end
    end
  end
end
