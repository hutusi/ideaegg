module API
  # Ideas API
  class Ideas < Grape::API
    before { authenticate! }

    resource :ideas do
      # Get a ideas list for authenticated user
      #
      # Parameters:
      #   none
      #
      # Example Request:
      #   GET /ideas
      get do
        @ideas = paginate Idea.all
        present @ideas, with: Entities::Idea
      end
    end
  end
end
