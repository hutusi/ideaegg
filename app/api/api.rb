Dir["#{Rails.root}/app/api/*.rb"].each {|file| require file}

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
  end
end
