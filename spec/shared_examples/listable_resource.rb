shared_examples_for "listable resource" do |resource|
  let(:response) { Factory.response }

  it 'with no filtering criterial' do
    url = "#{api_url}/#{formatted_resource_name(described_class, resource)}"

    expect(RestClient).to receive(:get).with(
      url,
      {headers: CTAAggregatorClient::APIClient::DEFAULT_HEADERS, params: {filter:  {}}}
    ).and_return(response)

    expect(described_class.list).to eq response
  end

  it 'with filtering' do
    url = "#{api_url}/#{formatted_resource_name(described_class, resource)}"
    filters = {foo: :bar}

    expect(RestClient).to receive(:get).with(
      url,
      {headers: CTAAggregatorClient::APIClient::DEFAULT_HEADERS, params: {filter:  filters}}
    ).and_return(response)

    expect(described_class.list(filters)).to eq response
  end
end
