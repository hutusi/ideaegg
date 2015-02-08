module API
  module APIHelpers
    PRIVATE_TOKEN_HEADER = "HTTP_PRIVATE_TOKEN"
    PRIVATE_TOKEN_PARAM = :private_token

    def current_user
      private_token = (params[PRIVATE_TOKEN_PARAM] || env[PRIVATE_TOKEN_HEADER]).to_s
      @current_user ||= User.find_by(private_token: private_token)
    end

    def authenticate!
      unauthorized! unless current_user
    end

    def ios_app?
      private_token = (params[PRIVATE_TOKEN_PARAM] || env[PRIVATE_TOKEN_HEADER]).to_s
      private_token == Settings['ios_app_key']
    end

    def authenticate_as_ios!
      unauthorized! unless ios_app?
    end

    def unauthorized!
      render_api_error!('401 Unauthorized', 401)
    end

    def bad_request!(attribute)
      message = ["400 (Bad request)"]
      message << "\"" + attribute.to_s + "\" not given"
      render_api_error!(message.join(' '), 400)
    end

    def not_found!(resource = nil)
      message = ["404"]
      message << resource if resource
      message << "Not Found"
      render_api_error!(message.join(' '), 404)
    end

    def render_validation_error!(model)
      unless model.valid?
        render_api_error!(model.errors.messages || '400 Bad Request', 400)
      end
    end

    def render_api_error!(message, status)
      error!({'message' => message}, status)
    end

    def paginate(relation)
      per_page  = params[:per_page].to_i
      paginated = relation.page(params[:page]).per(per_page)
      add_pagination_headers(paginated, per_page)

      paginated
    end

    def required_attributes!(keys)
      keys.each do |key|
        bad_request!(key) unless params[key].present?
      end
    end

    def attributes_for_keys(keys)
      attrs = {}

      keys.each do |key|
        if params[key].present? or (params.has_key?(key) and params[key] == false)
          attrs[key] = params[key]
        end
      end

      ActionController::Parameters.new(attrs).permit!
    end

    def authenticated_as_current_user(user)
      return unauthorized! unless user == current_user
    end

    private

      def add_pagination_headers(paginated, per_page)
        request_url = request.url.split('?').first

        links = []
        links << %(<#{request_url}?page=#{paginated.current_page - 1}&per_page=#{per_page}>; rel="prev") unless paginated.first_page?
        links << %(<#{request_url}?page=#{paginated.current_page + 1}&per_page=#{per_page}>; rel="next") unless paginated.last_page?
        links << %(<#{request_url}?page=1&per_page=#{per_page}>; rel="first")
        links << %(<#{request_url}?page=#{paginated.total_pages}&per_page=#{per_page}>; rel="last")

        header 'Link', links.join(', ')
      end
  end
end
