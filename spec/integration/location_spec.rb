require 'spec_helper'

describe CTAAggregatorClient::Location do

  it_behaves_like 'listable resource'
  it_behaves_like 'findable resource'
  it_behaves_like 'updatable resource'

  context 'creation' do
    attributes = {
      venue: 'Eastern Kemmer University',
      address_lines: ['684 Schinner Trail', 'Apt. 512'],
      locality: 'Rosenbaumville',
      region: 'VA',
      postal_code: '78183-3430'
    }
    it_behaves_like 'creatable resource', attributes
  end

end
