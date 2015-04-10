module API
  module Entities
    class UserBasic < Grape::Entity
      expose :id, :username, :fullname, :avatar
    end

    class User < UserBasic
      expose :level, :money
      expose :ideas_count, :comments_count
      expose :followees_count, :followers_count, :liked_ideas_count
    end
    
    class UserFull < User
      expose :email, :phone_number, :created_at, :updated_at, :sign_up_type
    end

    class UserLogin < UserFull
      expose :private_token, :wechat_openid
    end
    
    class IdeaBasic < Grape::Entity
      expose :id, :title, :content, :public
    end

    class Idea < IdeaBasic
      expose :created_at, :updated_at
      expose :comments_count, :cached_votes_up, :stars_count
      expose :author, using: Entities::UserBasic
    end
    
    class CommentBasic < Grape::Entity
      expose :id, :body, :commentable_id, :commentable_type, :user_id
    end

    class Comment < CommentBasic
      expose :created_at, :updated_at
      expose :commentator, using: Entities::UserBasic
    end
    
    class Tag < Grape::Entity
      expose :id, :name, :taggings_count
    end
  end
end
