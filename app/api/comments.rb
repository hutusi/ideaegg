module API
  # Comments API
  class Comments < Grape::API
    include Grape::Kaminari
    
    before { authenticate! }

    resource :ideas do
      paginate per_page: 10, max_per_page: 100

      # Get a comments list of an idea
      #
      # Parameters:
      #   id (idea)
      #
      # Example Request:
      #   GET /ideas/:id/comments
      get ":id/comments" do
        idea = Idea.find(params[:id])
        not_found!('Idea') unless idea

        comments = paginate idea.comment_threads
        present comments, with: Entities::Comment
      end

      # Create a comment for an idea
      #
      # Parameters:
      #   id (idea)
      #   body
      #
      # Example Request:
      #   POST /ideas/:id/comments
      post ":id/comments" do
        idea = Idea.find(params[:id])
        not_found!('Idea') unless idea

        required_attributes! [:body]
        attrs = attributes_for_keys([:body])
        comment = Comment.build_from( idea, current_user.id, attrs[:body] )
        present comment, with: Entities::Comment
      end
    end

    resource :comments do
      before { authenticate! }

      # Remove a comment
      #
      # Parameters:
      #   id (required)
      #
      # Example Request:
      #   DELETE /comments/:id
      delete ":id" do
        comment = Comment.find(params[:id])
        not_found!('Comment') unless comment
        authenticated_as_current_user comment.commentator

        render_validation_error!(comment) unless comment.destroy
      end
    end
  end
end
