require 'rspec'

module Factory

  class << self

    def response(code: 200, body: nil)
      CTAAggregatorClient::Response.new(
        code,
        body,
        { content_type: 'application/vnd.api+json' }
      )
    end

    def auth_response
      Factory.response(code: 201, body: {jwt: token}.to_json)
    end

    def bad_token_response
      Factory.response(code: 401)
    end

    def bad_auth_response
      Factory.response(code: 404)
    end

    def token
      'as.df.gh'
    end

  end
end
