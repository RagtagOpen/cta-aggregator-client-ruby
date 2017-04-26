require 'rest-client'
require 'json'
require 'cta_aggregator_client/response'

module CTAAggregatorClient
  module APIClient 

    DEFAULT_HEADERS = { content_type: 'application/vnd.api+json',
                        accept: 'application/vnd.api+json' }.freeze
    class << self

      def list(resource_name, filters)
        url = "#{base_url}/#{api_version}/#{resource_name}s"
        raw_response = RestClient.get(url, {headers: headers, params: {filter:  filters} })
        translate_response(raw_response)
      end

      def find(resource_name, uuid)
        url = "#{base_url}/#{api_version}/#{resource_name}s/#{uuid}"
        raw_response = RestClient.get(url, headers)
        translate_response(raw_response)
      end

      def create(resource_name, attributes)
        url = "#{base_url}/#{api_version}/#{resource_name}s"
        payload = {
          'data': {
            'type': "#{resource_name}s",
            'attributes': attributes
          }
        }.to_json

        perform_request(:post, url, payload)
      end

      def add_relationship(resource_name, uuid, related_resource_name, related_resource_uuid)
        url = "#{base_url}/#{api_version}/#{resource_name}s/#{uuid}/relationships/#{related_resource_name}"
        payload = {
          'data': {
            'type': "#{related_resource_name}s",
            'id': related_resource_uuid
          }
        }.to_json

        perform_request(:put, url, payload)
      end

      def perform_request(http_method, url, payload)
        raw_response = RestClient.send(http_method.to_sym, url, payload, headers)
        translate_response(raw_response)
      end

      def translate_response(response)
        Response.new(response.code, response.body, response.headers)
      end

      def headers
        DEFAULT_HEADERS
      end

      def base_url
        CTAAggregatorClient.configuration.base_url
      end

      def api_version
        CTAAggregatorClient.configuration.api_version
      end

    end
  end
end
