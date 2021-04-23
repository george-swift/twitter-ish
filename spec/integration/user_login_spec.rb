require 'rails_helper'

RSpec.describe 'Log in to Twitter-ish and log out', type: :feature do
  let(:user) { User.create(username: 'dev', fullname: 'Jane Doe') }

  scenario 'log in page' do
    visit login_path
    fill_in 'session_username', with: user.username
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('dev')
    expect(page).to have_content('Tweets')
    click_on 'Log Out'
    sleep(3)
    expect(page).to have_content('Log in')
  end
end
