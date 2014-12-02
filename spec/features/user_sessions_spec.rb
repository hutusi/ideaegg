require 'rails_helper'

feature "UserSessions" do
  before { @user = FactoryGirl.create(:user) }

  scenario 'User sign up' do
    new_user = FactoryGirl.build(:user)
    sign_up new_user
    expect(page).to have_content 'Sign out'
  end

  scenario 'User sign in with email' do
    sign_in_with_email @user

    expect(page).to have_content 'Sign out'

    first(:link, 'Sign out').click
    expect(page).to have_content 'Sign in'
  end

  scenario 'User sign in with username' do
    sign_in_with_username @user

    expect(page).to have_content 'Sign out'

    first(:link, 'Sign out').click
    expect(page).to have_content 'Sign in'
  end
end
