module API
  module Entities
    class UserBasic < Grape::Entity
      expose :username, :fullname, :email
    end

    class UserLogin < UserBasic
      expose :private_token
    end

    class Idea < Grape::Entity
      expose :id, :title, :content
      expose :author, using: Entities::UserBasic
    end
  end
end
