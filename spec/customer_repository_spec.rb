require_relative '../lib/customer_repository'

RSpec.describe CustomerRepository do
  let (:cr) { CustomerRepository.new('spec/fixtures/customers_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(cr).to be_an_instance_of(CustomerRepository)
  end

  describe 'Instance methods' do
    describe '#all' do
      it 'returns Array of all Customer instance' do
        expect(cr.all).to be_an_instance_of(Array)
        expect(cr.all[0]).to be_an_instance_of(Customer)
        expect(cr.all.count).to eq(42)
      end
    end

    describe '#find_by_id' do
      it 'returns matching instance of id provided' do
        customer = cr.find_by_id(319)

        expect(customer).to be_an_instance_of(Customer)
        expect(customer.first_name).to eq('Elmer')
        expect(customer.id).to eq(319)
      end

      it 'returns nil if no match found' do
        customer = cr.find_by_id(0)

        expect(customer).to be_nil
      end
    end
  end
end
