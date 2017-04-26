require 'spec_helper'

describe CTAAggregatorClient::Contact do

  it_behaves_like "listable resource"
  it_behaves_like "findable resource"
  context "creation" do
    attributes  = { 
      name: "john doe",
      email: "foobar@example.com"
    }
    expected_attributes = {
      'name': attributes[:name],
      'email': attributes[:email]
    }
    it_behaves_like "creatable resource", attributes, expected_attributes
  end

end
