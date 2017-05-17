shared_examples_for "findable resource" do |resource|
  let(:response) { Factory.response }

  it 'find record' do
    uuid = '123'

    url = "#{api_url}/#{formatted_resource_name(described_class, resource)}/#{uuid}"
    expect(RestClient).to receive(:get).with(
      url,
      CTAAggregatorClient::API::Client.default_headers
    ).and_return(response)

    expect(described_class.find(uuid)).to eq response
  end
end
