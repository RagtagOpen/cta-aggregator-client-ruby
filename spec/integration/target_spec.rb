require 'spec_helper'

describe CTAAggregatorClient::Target do

  it_behaves_like 'listable resource'
  it_behaves_like 'findable resource'
  it_behaves_like 'updatable resource'
  it_behaves_like 'deletable resource'

  context 'creation' do
    attributes = {
      organization: 'Mohr Inc',
      given_name: 'Pascale',
      family_name: 'White',
      ocdid: 'b4503418-6aab-451a-8e55-11ffd575bc85',
      postal_addresses: [
        {
          primary: true,
          address_type: 'Office',
          venue: 'Southern Nitzsche',
          address_lines: [
            '36261 Kovacek Prairie',
            'Apt. 760'

          ],
          locality: 'West Brandynfort',
          region: 'WV',
          postal_code: '66900-1309',
          country: 'US'
        }
      ],
      email_addresses: [
        {
          primary: true,
          address: 'jeffry_durgan@rutherfordcarroll.net',
          address_type: 'work'
        }

      ],
      phone_numbers: [
        {
          primary: true,
          number: '(606) 087-8543 x254',
          extension: '4594',
          number_type: 'work'
        }
      ]
    }
    it_behaves_like 'creatable resource', attributes
  end
end
