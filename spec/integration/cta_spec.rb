require 'spec_helper'

describe CTAAggregatorClient::CTA do
  let(:cta_uuid) { '123' }
  let(:response) { Factory.response }

  it_behaves_like "listable resource", :cta
  it_behaves_like "findable resource", :cta

  context "creation" do
    attributes = {
      title: "enim tempor ut in aliquip",
      description: "Excepteur dolore enim voluptate qui",
      cta_type: "onsite",
      free: true,
      website: "www.foobar.com",
      start_time: 1524175800,
      end_time: 1524186600,
      location_id: '4321'
    }

    expected_attributes = {
      'title': attributes[:title],
      'description': attributes[:description],
      'website': attributes[:website],
      'free': attributes[:free],
      'start-time': attributes[:start_time],
      'end-time': attributes[:end_time],
      'cta-type': attributes[:cta_type],
      'location-id': attributes[:location_id]
    }

    it_behaves_like "creatable resource", attributes, expected_attributes, :cta
  end

  it 'add a contact' do
    contact_uuid = '456'
    url = "#{api_url}/#{:ctas}/#{cta_uuid}/relationships/contact"
    payload = {
      'data': {
        'type': 'contacts',
        'id': contact_uuid
      }
    }

    expect(RestClient).to receive(:put).with(
      url,
      payload.to_json,
      CTAAggregatorClient::APIClient::DEFAULT_HEADERS
    ).and_return(response)

    expect(described_class.add_contact(cta_uuid, contact_uuid)).to eq response
  end

  it 'add location' do
    location_uuid = '456'
    url = "#{api_url}/#{:ctas}/#{cta_uuid}/relationships/location"
    payload = {
      'data': {
        'type': 'locations',
        'id': location_uuid
      }
    }

    expect(RestClient).to receive(:put).with(
      url,
      payload.to_json,
      CTAAggregatorClient::APIClient::DEFAULT_HEADERS
    ).and_return(response)

    expect(described_class.add_location(cta_uuid, location_uuid)).to eq response
  end

  it 'add call script' do
    call_script_uuid = '789'
    url = "#{api_url}/#{:ctas}/#{cta_uuid}/relationships/call_script"
    payload = {
      'data': {
        'type': 'call_scripts',
        'id': call_script_uuid
      }
    }

    expect(RestClient).to receive(:put).with(
      url,
      payload.to_json,
      CTAAggregatorClient::APIClient::DEFAULT_HEADERS
    ).and_return(response)

    expect(described_class.add_call_script(cta_uuid, call_script_uuid)).to eq response
  end
end
