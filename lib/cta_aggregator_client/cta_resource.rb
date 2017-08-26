require 'cta_aggregator_client/api/client'

module CTAAggregatorClient
  module CTAResource

    def list(filters = {})
      API::Client.list(resource_name, filters)
    end

    def find(uuid)
      API::Client.find(resource_name, uuid)
    end

    def create(attributes)
      if relationships
        relationship_data = { relationships => attributes.delete(relationships) }
      end

      API::Client.create(resource_name, attributes, relationship_data)
    end

    def update(attributes)
      uuid = attributes.delete(:id)
      API::Client.update(resource_name, uuid, attributes)
    end

    def delete(uuid)
      API::Client.delete(resource_name, uuid)
    end

    def resource_name
      raise NotImplementedError
    end

    def relationships
      nil
    end

  end
end
