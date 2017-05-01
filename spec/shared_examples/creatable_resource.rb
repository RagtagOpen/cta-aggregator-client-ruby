shared_examples_for "creatable resource" do |passed_attrs, expected_attrs, resource|
  let(:response) { Factory.response }
  let(:auth_response) { Factory.auth_response }
  let(:token) { Factory.token }

  context 'with successful authentication' do

    after do
      CTAAggregatorClient::API::Authenticator.reset_auth
    end

    it 'create new record' do
      resource_name = formatted_resource_name(described_class, resource)

      url = "#{api_url}/#{resource_name}"
      payload = {
        'data': {
          'type': resource_name,
          'attributes': expected_attrs
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

      expect(RestClient).to receive(:post).with(
        url,
        payload.to_json,
        headers_with_auth_token
      ).and_return(response)

      expect(described_class.create(passed_attrs)).to eq response
    end
  end

  context 'with unsuccessful authentication' do
    before do
      CTAAggregatorClient.configure do |config|
        config.api_key = 'bad_key'
        config.api_secret = 'bad_secret'
      end
    end

    after do
      CTAAggregatorClient::API::Authenticator.reset_auth
    end

    it 'fails when auth creds wrong' do
      resource_name = formatted_resource_name(described_class, resource)

      url = "#{api_url}/#{resource_name}"
      payload = {
        'data': {
          'type': resource_name,
          'attributes': expected_attrs
        }
      }

      headers_with_auth_creds = CTAAggregatorClient::API::Client.default_headers.merge(
        authorization: "#{'bad_key'}:#{'bad_secret'}"
      )

      allow(RestClient).to receive(:post).with(
        auth_url,
        nil,
        headers_with_auth_creds
      ).and_return(Factory.bad_auth_response)

      header_sans_auth_token = CTAAggregatorClient::API::Client.default_headers.merge(
        authorization: "Bearer: #{nil}"
      )

      expect(RestClient).to receive(:post).with(
        url,
        payload.to_json,
        header_sans_auth_token
      ).and_return(Factory.bad_token_response)

      expect(described_class.create(passed_attrs).code).to eq 401
    end
  end

end
