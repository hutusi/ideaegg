module API
  module APIHelpers
    def unauthorized!
      render_api_error!('401 Unauthorized', 401)
    end

    def render_validation_error!(model)
      unless model.valid?
        render_api_error!(model.errors.messages || '400 Bad Request', 400)
      end
    end

    def render_api_error!(message, status)
      error!({'message' => message}, status)
    end
  end
end
