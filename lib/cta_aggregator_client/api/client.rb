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

        def create(resource_name, attributes, relationships = {})
          url = "#{base_url}/#{api_version}/#{resource_name}s"
          payload = {
            'data': {
              'type': "#{resource_name}s",
              'attributes': attributes,
              'relationships': relationship_params(relationships)
            }.reject{ |k,v| v.empty? }
          }.to_json

          perform_authenticated_request(:post, url, payload)
        end

        def relationship_params(relationships)
          return {} unless relationships

          relationships.each_with_object({}) do |(resource_name, uuid_data), obj|
            if uuid_data.is_a? Array
              obj[resource_name.to_sym] = {
                data: uuid_data.map {  |uuid| { type: resource_name, id: uuid } }
              }
            else
              obj[resource_name.to_sym] = {
                data: { type: "#{resource_name}s", id: uuid_data }
              }
            end
          end
        end

        def add_relationship(resource_name, uuid, related_resource_name, related_resource_uuids)
          url = "#{base_url}/#{api_version}/#{resource_name}s/#{uuid}/relationships/#{related_resource_name}"
          if related_resource_uuids.is_a? Array

            resource_data = related_resource_uuids.map do |related_resource_uuid|
              { 'type': "#{related_resource_name}",
                'id': related_resource_uuid }
            end

          elsif related_resource_uuids.is_a? String
            resource_data = { 'type': "#{related_resource_name}",
                              'id': related_resource_uuids }
          else
            raise UnknownInputTypeError
          end

          payload = { data: resource_data }.to_json

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

        class UnknownInputTypeError < StandardError ; end
      end
    end
  end
end
