require 'cta_aggregator_client/api/utilities'

module CTAAggregatorClient
  module API
    module Authenticator 
      extend Utilities

      THREE_HOURS = 10800

      class << self

        def headers_with_authentication 
          reset_auth unless Time.now < auth.expiration
          default_headers.merge(authorization: "Bearer: #{auth.token}")
        end

        def auth
          @auth ||= generate_auth
        end

        def generate_auth
          raw_response = RestClient.post(auth_url, nil, headers_with_auth_creds)
          token = raw_response.code == 201 ? JSON.parse(raw_response.body)["jwt"] : nil

          Auth.new(
            token,
            default_token_expiration
          )
        end

        def default_token_expiration
          # API is more lenient on token expriation (way over 3 hours).
          # We're keeping low expiration here to avoid dealing with expired tokens.
          Time.now + THREE_HOURS
        end

        def reset_auth
          @auth = nil
        end

        class Auth < Struct.new(:token, :expiration) ; end

      end
    end
  end
end
