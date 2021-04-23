require 'rails_helper'

RSpec.describe Opinion, type: :model do
  fixtures :users
  fixtures :opinions

  let(:jarvis) { users(:jarvis) }
  let(:recent) { opinions(:most_recent) }

  subject(:opinion) { jarvis.opinions.build(text: 'Testing with Rspec') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(opinion).to be_valid
    end

    it 'is not valid without an author_id' do
      opinion.author_id = nil
      expect(opinion).to_not be_valid
    end

    it 'is not valid without text' do
      opinion.text = '   '
      expect(opinion).to_not be_valid
    end

    it 'is not not have more than 140 characters' do
      opinion.text = 'a' * 141
      expect(opinion).to_not be_valid
    end
  end

  describe 'order' do
    context 'tweets should be sorted' do
      it 'is sorted by most recent' do
        expect(recent).to eq(Opinion.first)
      end
    end
  end
end
