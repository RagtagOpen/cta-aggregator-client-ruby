shared_examples_for "creatable resource" do |passed_attrs, expected_attrs, resource|
  let(:response) { Factory.response }

  it 'create new record' do
    resource_name = formatted_resource_name(described_class, resource)
 
    url = "#{api_url}/#{resource_name}"
    payload = {
      'data': {
        'type': resource_name,
        'attributes': expected_attrs
      }
    }

    expect(RestClient).to receive(:post).with(
      url,
      payload.to_json,
      CTAAggregatorClient::APIClient::DEFAULT_HEADERS
    ).and_return(response)

    expect(described_class.create(passed_attrs)).to eq response
  end

end
