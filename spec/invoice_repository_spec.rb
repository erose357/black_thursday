require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  let (:in_r) { InvoiceRepository.new('spec/fixtures/invoices_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(in_r).to be_an_instance_of(InvoiceRepository)
  end

  context 'Instance methods' do
    describe '#all' do
      it 'returns Array of all Invoice instances' do
        expect(in_r.all).to be_an_instance_of(Array)
        expect(in_r.all[0]).to be_an_instance_of(Invoice)
        expect(in_r.all.length).to eq(42)
      end
    end

    describe '#find_by_id' do
      it 'returns an invoice instance matching the id supplied' do
        expect(in_r.find_by_id(580)).to be_an_instance_of(Invoice)
        expect(in_r.find_by_id(580).status).to eq(:shipped)
        expect(in_r.find_by_id(580).merchant_id).to eq(12334132)
      end

      it 'returns nil if no match found' do
        expect(in_r.find_by_id(0)).to be_nil
      end
    end

    describe '#find_all_by_customer_id' do
      it 'returns Array one or more matches for the customer_id supplied' do
        invoices = in_r.find_all_by_customer_id(220)

        expect(invoices).to be_an_instance_of(Array)
        expect(invoices[0]).to be_an_instance_of(Invoice)
        expect(invoices.count).to eq(1)
        expect(in_r.find_all_by_customer_id(259)[0].merchant_id).to eq(12334132)
      end

      it 'returns [] if no matches found' do
        invoices = in_r.find_all_by_customer_id(0)

        expect(invoices).to eq([])
      end
    end

    describe '#find_all_by_merchant_id' do
      it 'returns Array one or more matches for merchant_id supplied' do
        invoices = in_r.find_all_by_merchant_id(12334141)

        expect(invoices).to be_an_instance_of(Array)
        expect(invoices[0]).to be_an_instance_of(Invoice)
        expect(invoices.count).to eq(5)
        expect(in_r.find_all_by_merchant_id(12334132).count).to eq(4)
      end

      it 'returns [] if no matches found' do
        invoices = in_r.find_all_by_merchant_id(0)

        expect(invoices).to eq([])
      end
    end

    describe '#find_all_by_status' do
      it 'returns Array one or more matches for status supplied' do
        pending = in_r.find_all_by_status(:pending)
        shipped = in_r.find_all_by_status(:shipped)
        returned = in_r.find_all_by_status(:returned)

        expect(pending).to be_an_instance_of(Array)
        expect(pending[0]).to be_an_instance_of(Invoice)
        expect(pending.count).to eq(7)
        expect(shipped.count).to eq(29)
      end
    end

    describe '#find_all_by_date' do
      it 'returns Array of one or more matches for date supplied' do
        date = Time.parse('2005-01-03')
        result = in_r.find_all_by_date(date)

        expect(result.count).to eq(1)
        expect(result).to be_an_instance_of(Array)
        expect(result[0]).to be_an_instance_of(Invoice)
        expect(result[0].id).to eq(74)
      end

      it 'can search by updated_at or created_at attributes' do
        date = Time.parse('2014-10-01')
        result = in_r.find_all_by_date(date, 'updated_at')

        expect(result.count).to eq(1)
        expect(result).to be_an_instance_of(Array)
        expect(result[0]).to be_an_instance_of(Invoice)
        expect(result[0].id).to eq(1195)
      end
    end
  end
end
