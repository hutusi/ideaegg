Dir["#{Rails.root}/app/api/*.rb"].each {|file| require file}

module API
  class API < Grape::API
    version 'v1', using: :path
    format :json

    helpers APIHelpers
    helpers SessionsHelper

    mount Users
  end
end
