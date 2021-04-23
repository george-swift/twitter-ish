require 'rails_helper'

RSpec.describe 'Updating a profile', type: :feature do
  let(:user) { User.create(username: 'seconddev', fullname: 'John Doe') }

  scenario 'editing with valid inputs after log in' do
    visit login_path
    fill_in 'session_username', with: user.username
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('seconddev')
    visit edit_user_path(id: user.id)
    fill_in 'user_fullname', with: 'New name'
    click_on 'Save changes'
    sleep(3)
    expect(page).to have_content('New name')
  end

  scenario 'editing with invalid inputs after log in' do
    visit login_path
    fill_in 'session_username', with: user.username
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('seconddev')
    visit edit_user_path(id: user.id)
    fill_in 'user_username', with: ' '
    click_on 'Save changes'
    expect(page).to have_content("Username can't be blank")
  end
end
