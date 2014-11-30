module ApplicationHelper
  def sign_in_button
    link_to 'Sign in', new_user_session_path, class: 'btn btn-default btn-primary btn-sign-in'
  end
end
