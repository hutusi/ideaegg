module API
  # Tags API
  class Tags < Grape::API
    include Grape::Kaminari

    before { authenticate! }

    resource :tags do
      paginate per_page: 10, max_per_page: 100

      # Get a tags list for authenticated user
      #
      # Parameters:
      #   none
      #
      # Example Request:
      #   GET /tags
      get do
        @tags = paginate ActsAsTaggableOn::Tag.order('taggings_count DESC').all
        present @tags, with: Entities::Tag
      end
    end
  end
end