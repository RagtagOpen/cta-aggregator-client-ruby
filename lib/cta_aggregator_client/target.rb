require 'cta_aggregator_client/cta_resource'

module CTAAggregatorClient
  module Target 
    extend CTAResource

    RESOURCE_NAME = :target

    class << self

      def resource_name
        RESOURCE_NAME
      end

    end
  end
end
