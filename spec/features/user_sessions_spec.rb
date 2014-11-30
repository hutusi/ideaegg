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

  scenario 'User sign in with email' do
    user = FactoryGirl.create(:user)

    visit root_path
    first(:link, 'Sign in').click
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content 'Sign out'

    first(:link, 'Sign out').click
    expect(page).to have_content 'Sign in'
  end

  scenario 'User sign in with username' do
    user = FactoryGirl.create(:user)

    visit root_path
    first(:link, 'Sign in').click
    fill_in 'Login', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content 'Sign out'

    first(:link, 'Sign out').click
    expect(page).to have_content 'Sign in'
  end
end
