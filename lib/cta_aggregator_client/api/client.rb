require 'rest-client'
require 'json'
require 'cta_aggregator_client/response'
require 'cta_aggregator_client/api/utilities'
require 'cta_aggregator_client/api/authenticator'

module CTAAggregatorClient
  module API
    module Client 
      extend Utilities

      class << self

        def list(resource_name, filters)
          url = "#{base_url}/#{api_version}/#{resource_name}s"
          raw_response = RestClient.get(url, {headers: default_headers, params: {filter:  filters} })
          translate_response(raw_response)
        end

        def find(resource_name, uuid)
          url = "#{base_url}/#{api_version}/#{resource_name}s/#{uuid}"
          raw_response = RestClient.get(url, default_headers)
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

          perform_authenticated_request(:post, url, payload)
        end

        def add_relationship(resource_name, uuid, related_resource_name, related_resource_uuid)
          url = "#{base_url}/#{api_version}/#{resource_name}s/#{uuid}/relationships/#{related_resource_name}"
          payload = {
            'data': {
              'type': "#{related_resource_name}s",
              'id': related_resource_uuid
            }
          }.to_json

          perform_authenticated_request(:put, url, payload)
        end

        def perform_authenticated_request(http_method, url, payload)
          raw_response = RestClient.send(http_method.to_sym, url, payload, headers_with_access_token)
          translate_response(raw_response)
        end

        def headers_with_access_token
          Authenticator.headers_with_authentication
        end

        def translate_response(response)
          Response.new(response.code, response.body, response.headers)
        end

      end
    end
  end
end
