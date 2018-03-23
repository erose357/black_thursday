require 'sales_engine'

RSpec.describe SalesEngine do
  let (:file_paths) { { merchants:  'spec/fixtures/merchants_fixture.csv' } }
  let (:se) { SalesEngine.from_csv(file_paths) }

  it 'is a valid instance' do
    expect(se).to be_an_instance_of(SalesEngine)
  end

  describe 'Attributes' do
    it 'can access merchants attribute' do
      expect(se.merchants).to be_an_instance_of(MerchantRepository)
    end
  end
end
