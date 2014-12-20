module API
  module Entities
    class UserBasic < Grape::Entity
      expose :username, :fullname, :email
    end
  end
end
