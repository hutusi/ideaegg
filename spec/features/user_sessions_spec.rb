require 'rails_helper'

feature "UserSessions" do
  scenario 'User sign up' do
    user = FactoryGirl.build(:user)
    sign_up user
    expect(page).to have_content 'Sign out'
  end

  scenario 'User sign in with email' do
    user = FactoryGirl.create(:user)
    sign_in_with_email user

    expect(page).to have_content 'Sign out'

    first(:link, 'Sign out').click
    expect(page).to have_content 'Sign in'
  end

  scenario 'User sign in with username' do
    user = FactoryGirl.create(:user)
    sign_in_with_username user

    expect(page).to have_content 'Sign out'

    first(:link, 'Sign out').click
    expect(page).to have_content 'Sign in'
  end
end
