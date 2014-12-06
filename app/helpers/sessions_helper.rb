module SessionsHelper
  def signed_in_user
    unless user_signed_in?
      redirect_to sign_in_url, notice: 'Please sign in.'
    end
  end
end
