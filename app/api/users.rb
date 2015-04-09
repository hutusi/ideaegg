module API
  # Users API
  class Users < Grape::API
    include Grape::Kaminari

    before { authenticate! }

    resource :users do
      paginate per_page: 10, max_per_page: 100
      
      # Get a users list
      #
      # Parameters:
      #   none
      #
      # Example Request:
      #   GET /users
      get do
        @users = paginate User.all
        present @users, with: Entities::User
      end

      # Get a specific user
      #
      # Parameters:
      #   id (required) - The ID of a user
      # Example Request:
      #   GET /users/:id
      get ":id" do
        @user = User.find(params[:id])
        present @user, with: Entities::UserFull
      end

      # Update user
      #
      # Parameters:
      #   username
      #   fullname
      #   email
      #   wechat_openid
      # Example Request
      #   PUT /users/:id
      put ":id" do
        @user = User.find(params[:id])
        not_found!('User') unless @user
        authenticated_as_current_user @user

        attrs = attributes_for_keys [:username, :fullname, :email, 
                                 :wechat_openid, :level, :money, :phone_number, 
                                 :avatar ]
        if @user.update_attributes(attrs)
          present @user, with: Entities::User
        else
          render_validation_error!(@user)
        end
      end

      # Follow user
      #
      # Parameters:
      #   id (required)
      # Example Request
      #   POST /users/:id/follow
      post ":id/follow" do
        @user = User.find(params[:id])
        not_found!('User') unless @user

        follow_other(current_user, @user)
      end

      # Unfollow user
      #
      # Parameters:
      #   id (required)
      # Example Request
      #   DELETE /users/:id/follow
      delete ":id/follow" do
        @user = User.find(params[:id])
        not_found!('User') unless @user

        unfollow_other(current_user, @user)
      end
    end
    
    # Get my ideas
    #
    # Parameters:
    #   
    # Example Request:
    #   GET /my/ideas
    get "/my/ideas" do
      @ideas = paginate current_user.ideas
      present @ideas, with: Entities::Idea
    end
    
    # Get my liked ideas
    #
    # Parameters:
    #   
    # Example Request:
    #   GET /my/liked_ideas
    get "/my/liked_ideas" do
      @ideas = paginate current_user.all_likes
      present @ideas, with: Entities::Idea
    end
    
    # Get my starred ideas
    #
    # Parameters:
    #   
    # Example Request:
    #   GET /my/starred_ideas
    get "/my/starred_ideas" do
      @ideas = paginate current_user.starred_ideas
      present @ideas, with: Entities::Idea
    end
    
  end
end
