require 'rails_helper'

feature "UserSessions" do
  scenario 'User sign up' do
    user = FactoryGirl.build(:user)

    visit root_path
    first(:link, 'Sign in').click
    click_link 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    
    expect(page).to have_content 'Sign out'
  end
end
