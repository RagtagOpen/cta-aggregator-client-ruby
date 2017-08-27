module CTAAggregatorClient
  module API
    module Utilities

      def default_headers
        { content_type: 'application/vnd.api+json',
          accept: 'application/vnd.api+json'}
      end

      def headers_with_auth_creds
        default_headers.merge(authorization: "#{api_key}:#{api_secret}")
      end

      def base_url
        CTAAggregatorClient.configuration.base_url
      end

      def api_version
        CTAAggregatorClient.configuration.api_version
      end

      def auth_url
        "#{base_url}/#{api_version}/authentications"
      end

      def api_key
        CTAAggregatorClient.configuration.api_key
      end

      def api_secret
        CTAAggregatorClient.configuration.api_secret
      end

    end
  end
end
