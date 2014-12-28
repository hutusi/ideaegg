module ApiSpecHelpers
  # Public: Prepend a request path with the path to the API
  #
  # path - Path to append
  # user - User object - If provided, automatically appends private_token query
  #          string for authenticated requests
  #
  # Examples
  #
  #   >> api('/ideas')
  #   => "/api/v1/ideas"
  #
  #   >> api('/ideas', User.last)
  #   => "/api/v1/ideas?private_token=..."
  #
  #   >> api('/ideas?foo=bar', User.last)
  #   => "/api/v1/ideas?foo=bar&private_token=..."
  #
  # Returns the relative path to the requested API resource
  def api(path, user = nil)
    "/api/v1#{path}" +

    # Normalize query string
    (path.index('?') ? '' : '?') +

    # Append private_token if given a User object
    (user.respond_to?(:private_token) ?
    "&private_token=#{user.private_token}" : "")
  end

  def json_response
    JSON.parse(response.body)
  end
end
