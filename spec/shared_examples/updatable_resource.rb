shared_examples_for "updatable resource" do |resource|
  let(:response) { Factory.response }
  let(:auth_response) { Factory.auth_response }
  let(:token) { Factory.token }
  let(:uuid) { '123' }
  let(:attrs_to_change) { {foo: :bar} }
  let(:attrs) { {id: uuid}.merge(attrs_to_change) }

  after do
    CTAAggregatorClient::API::Authenticator.reset_auth
  end

  it 'updates record' do
    url = "#{api_url}/#{formatted_resource_name(described_class, resource)}/#{uuid}"

    payload = {
      'data': {
        'type': formatted_resource_name(described_class, resource),
        'attributes': attrs_to_change,
      }
    }

    allow(RestClient).to receive(:post).with(
      auth_url,
      nil,
      headers_with_auth_creds
    ).and_return(auth_response)

    headers_with_auth_token = CTAAggregatorClient::API::Client.default_headers.merge(
      authorization: "Bearer: #{token}"
    )

    expect(RestClient).to receive(:put).with(
      url,
      payload.to_json,
      headers_with_auth_token
    ).and_return(response)

    expect(described_class.update(attrs)).to eq response
  end
end
