Dir["#{Rails.root}/app/api/*.rb"].each {|file| require file}

module API
  class API < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
      def unauthorized!
        render_api_error!('401 Unauthorized', 401)
      end

      def render_api_error!(message, status)
        error!({'message' => message}, status)
      end
    end

    helpers SessionsHelper

    post "/signin" do
      user = authenticate_user(params[:login], params[:password])

      return unauthorized! unless user
      present user, with: Entities::UserBasic
    end
  end
end
