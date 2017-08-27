shared_examples_for "deletable resource" do |resource|
  let(:response) { Factory.response }
  let(:auth_response) { Factory.auth_response }
  let(:token) { Factory.token }
  let(:uuid) { '123' }

  after do
    CTAAggregatorClient::API::Authenticator.reset_auth
  end

  it 'updates record' do
    url = "#{api_url}/#{formatted_resource_name(described_class, resource)}/#{uuid}"

    allow(RestClient).to receive(:post).with(
      auth_url,
      nil,
      headers_with_auth_creds
    ).and_return(auth_response)

    headers_with_auth_token = CTAAggregatorClient::API::Client.default_headers.merge(
      authorization: "Bearer: #{token}"
    )

    expect(RestClient).to receive(:delete).with(
      url,
      headers_with_auth_token
    ).and_return(response)

    expect(described_class.delete(uuid)).to eq response
  end
end
