Dir["#{Rails.root}/app/api/*.rb"].each {|file| require file}
require 'securerandom'

module API
  class API < Grape::API
    version 'v1', using: :path
    format :json

    helpers APIHelpers
    helpers SessionsHelper
    helpers IdeasHelper
    helpers UsersHelper

    mount Users
    mount Ideas
    mount Comments
    mount Tags

    post "/sign_up" do
      user = User.new(:username => params[:username],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation])
      if user.save
        present user, with: Entities::UserLogin
      else
        render_validation_error!(user)
      end
    end

    post "/sign_in" do
      user = authenticate_user(params[:login], params[:password])

      return unauthorized! unless user
      present user, with: Entities::UserLogin
    end

    post "/sign_in_by_wechat" do
      user = authenticate_user_by_wechat_openid(params[:openid])

      return unauthorized! unless user
      present user, with: Entities::UserLogin
    end

    post "/sign_up_by_wechat" do
      username = params[:username] || "idea#{Time.now.strftime('%Y%m%d%H%M%S%L')}"
      email = params[:email] || "#{username}@ideaegg-wechat.com"
      password = params[:password] || SecureRandom.hex(8)
      password_confirmation = params[:password_confirmation] || password
      
      user = User.new(:wechat_openid => params[:openid],
      :username => username,
      :email => email,
      :password => password,
      :password_confirmation => password_confirmation,
      :sign_up_type => "wechat" )

      if user.save
        present user, with: Entities::UserLogin
      else
        render_validation_error!(user)
      end
    end

    get "/app_setting" do
      authenticate_as_ios!

      { qiniu: { access_key: Settings['qiniu']['access_key'],
                 secret_key: Settings['qiniu']['secret_key'],
                 bucket: Settings['qiniu']['bucket'] }
      }
    end
  end
end
