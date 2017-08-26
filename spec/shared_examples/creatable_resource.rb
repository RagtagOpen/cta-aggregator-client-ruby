shared_examples_for "creatable resource" do |passed_attrs, passed_relationships, resource|
  let(:response) { Factory.response }
  let(:auth_response) { Factory.auth_response }
  let(:token) { Factory.token }

  def relationships(relationship_hash)
    return {} unless relationship_hash && relationship_hash.reject { |k,v| v.nil? }.any?

    relationship_hash.each_with_object({}) do |(resource_name, uuid_data), obj|
      if uuid_data.is_a? Array
        obj[resource_name.to_sym] = {
          data: uuid_data.map {  |uuid| { type: resource_name, id: uuid } }
        }
      else
        obj[resource_name.to_sym] = {
          data: { type: "#{resource_name}s", id: uuid_data }
        }
      end
    end
  end

  context 'with successful authentication' do

    after do
      CTAAggregatorClient::API::Authenticator.reset_auth
    end

    it 'create new record' do
      resource_name = formatted_resource_name(described_class, resource)

      url = "#{api_url}/#{resource_name}"
      payload_params = passed_attrs.clone
      relationship_data = { passed_relationships => payload_params.delete(passed_relationships) }

      payload = {
        'data': {
          'type': resource_name,
          'attributes': payload_params,
          'relationships': relationships(relationship_data)
        }.reject{ |k,v| v.empty? }
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
      payload_params = passed_attrs.clone
      relationship_data = { passed_relationships => payload_params.delete(passed_relationships) }

      payload = {
        'data': {
          'type': resource_name,
          'attributes': payload_params,
          'relationships': relationships(relationship_data)
        }.reject{ |k,v| v.empty? }
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
