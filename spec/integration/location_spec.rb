require 'spec_helper'

describe CTAAggregatorClient::Location do

  it_behaves_like "listable resource"
  it_behaves_like "findable resource"
  context "creation" do
    attributes = { address: "123 fake st", zipcode: "66666" }
    expected_attrs = {
      'address': attributes[:address],
      'zipcode': attributes[:zipcode]
    }
    it_behaves_like "creatable resource", attributes, expected_attrs
  end

end
