module SessionsHelper
  def signed_in_user
    unless user_signed_in?
      redirect_to sign_in_url, notice: 'Please sign in.'
    end
  end

  def authenticate_user(login, password)
    user = User.by_login(login)
    (user.valid_password?(password) ? user : nil) unless user.nil?
  end

  def authenticate_user_by_wechat_openid(openid)
    User.find_by_wechat_openid(openid)
  end
end
