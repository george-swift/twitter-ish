require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  subject(:user) { User.new(username: 'example', fullname: 'Example User') }
  let(:jarvis) { users(:jarvis) }
  let(:alexa) { users(:alexa) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user.username = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a fullname' do
      user.fullname = nil
      expect(user).to_not be_valid
    end

    it 'is not valid if username is less than two characters' do
      user.username = 'a'
      expect(user).to_not be_valid
    end

    it 'is not valid if fullname is less than three characters' do
      user.fullname = 'aa'
      expect(user).to_not be_valid
    end
  end

  describe '#follow' do
    context 'following other users' do
      before do
        user.follow(jarvis)
      end

      it 'is following one user' do
        expect(user.following.size).to eq(1)
      end

      it 'follows many users' do
        user.follow(alexa)
        expect(user.following.size).to eq(2)
      end
    end
  end

  describe '#unfollow' do
    context 'unfollowing other users' do
      before do
        user.follow(jarvis)
        user.follow(alexa)
      end

      it 'unfollows a user' do
        user.unfollow(alexa)
        expect(user.following.size).not_to eq(2)
      end
    end
  end
end
