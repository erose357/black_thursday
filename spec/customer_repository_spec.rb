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

    describe '#find_all_by_first_name' do
      it 'returns one or more matches of first name to the substring provided' do
        customer_1 = cr.find_all_by_first_name('Flossie')
        customer_2 = cr.find_all_by_first_name('Mi')

        expect(customer_1).to be_an_instance_of(Array)
        expect(customer_1[0]).to be_an_instance_of(Customer)
        expect(customer_1[0].id).to eq(33)

        expect(customer_2).to be_an_instance_of(Array)
        expect(customer_2[0]).to be_an_instance_of(Customer)
        expect(customer_2.map(&:id)).to include(785,182)
      end

      it 'returns [] if no match found' do
        customer = cr.find_all_by_first_name('XX')

        expect(customer).to eq([])
      end
    end

    describe '#find_all_by_last_name' do
      it 'returns one or more matches of last name to the substring provided' do
        customer_1 = cr.find_all_by_last_name('er')
        customer_2 = cr.find_all_by_last_name('Haag')

        expect(customer_1).to be_an_instance_of(Array)
        expect(customer_1[0]).to be_an_instance_of(Customer)
        expect(customer_1.map(&:id)).to include(14, 28, 339, 106, 471, 127, 206)

        expect(customer_2).to be_an_instance_of(Array)
        expect(customer_2[0]).to be_an_instance_of(Customer)
        expect(customer_2.count).to eq(1)
        expect(customer_2[0].id).to eq(157)
      end

      it 'returns [] if no matches found' do
        customer = cr.find_all_by_first_name('XX')

        expect(customer).to eq([])
      end
    end
  end
end
