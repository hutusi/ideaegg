module SessionsMacros
  def sign_up(user)
    visit root_path
    first(:link, 'Sign in').click
    click_link 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
  end

  def sign_in_with_email(user)
    visit root_path
    first(:link, 'Sign in').click
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  def sign_in_with_username(user)
    visit root_path
    first(:link, 'Sign in').click
    fill_in 'Login', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
