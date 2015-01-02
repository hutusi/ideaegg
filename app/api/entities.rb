module API
  module Entities
    class UserBasic < Grape::Entity
      expose :id, :username, :fullname, :email
    end

    class User < UserBasic
    end

    class UserLogin < User
      expose :private_token
    end

    class Idea < Grape::Entity
      expose :id, :title, :content
      expose :author, using: Entities::UserBasic
    end

    class Comment < Grape::Entity
      expose :id, :body, :commentable_id, :commentable_type, :user_id
      expose :commentator, using: Entities::UserBasic
    end
  end
end
