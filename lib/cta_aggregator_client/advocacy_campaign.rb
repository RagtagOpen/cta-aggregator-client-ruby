require 'cta_aggregator_client/cta_resource'
module CTAAggregatorClient
  module AdvocacyCampaign
    extend CTAResource

    RESOURCE_NAME = :advocacy_campaign
    RELATIONSHIPS = :targets

    class << self

      def resource_name
        RESOURCE_NAME
      end

      def relationships
        RELATIONSHIPS
      end

    end
  end
end
