require 'spec_helper'

describe CTAAggregatorClient::CallScript do

  it_behaves_like "listable resource"
  it_behaves_like "findable resource"
  context "creation" do
    attributes = { 'text': 'lorem ipsum' }
    expected_attributes = { 'text': attributes[:text] }
    it_behaves_like "creatable resource", attributes, expected_attributes
  end
end
