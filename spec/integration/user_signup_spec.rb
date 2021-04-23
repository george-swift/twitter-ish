require 'rails_helper'

RSpec.describe 'Signing up to Twitter-ish', type: :feature do
  scenario 'valid inputs' do
    visit signup_path
    fill_in 'user_fullname', with: 'Code Reviewer'
    fill_in 'user_username', with: 'Eric'
    click_button 'Sign up'
    sleep(3)
    expect(page).to have_content('Eric')
  end

  scenario 'invalid inputs' do
    visit signup_path
    fill_in 'user_fullname', with: '  '
    fill_in 'user_username', with: 'Eric'
    click_button 'Sign up'
    expect(page).to have_content("Fullname can't be blank")
  end
end
