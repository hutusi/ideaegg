module API
  module Entities
    class UserBasic < Grape::Entity
      expose :username, :fullname, :email
    end

    class UserLogin < UserBasic
      expose :private_token
    end
  end
end
