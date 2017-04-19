require 'cta_aggregator_client/api_client'

module CTAAggregatorClient
  module CTA 
    class << self

      def list(filters = {})
        APIClient.list(:cta, filters)
      end

      def find(uuid)
        APIClient.find(:cta, uuid)
      end

      def create(attributes = {})
        attributes = {
          'title': attributes[:title],
          'description': attributes[:description],
          'website': attributes[:website],
          'free': attributes[:free],
          'start-time': attributes[:start_time],
          'end-time': attributes[:end_time],
          'cta-type': attributes[:cta_type],
          'location-id': attributes[:location_id],
          'contact-id': attributes[:contact_id],
          'call-script-id': attributes[:call_script_id]
        }.reject{ |k,v| v.nil? }

        APIClient.create(:cta, attributes)
      end

      def add_contact(cta_uuid, contact_uuid)
        APIClient.add_relationship(:cta, cta_uuid, :contact, contact_uuid)
      end

      def add_location(cta_uuid, location_uuid)
        APIClient.add_relationship(:cta, cta_uuid, :location, location_uuid)
      end

      def add_call_script(cta_uuid, call_script_uuid)
        APIClient.add_relationship(:cta, cta_uuid, :call_script, call_script_uuid)
      end
    end
  end
end
