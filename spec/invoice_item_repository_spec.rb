require_relative '../lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let (:iir) { InvoiceItemRepository.new('spec/fixtures/invoice_items_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(iir).to be_an_instance_of(InvoiceItemRepository)
  end

  describe 'Instance methods' do
    describe '#all' do
      it 'returns Array of all instances' do
        expect(iir.all).to be_an_instance_of(Array)
        expect(iir.all[0]).to be_an_instance_of(InvoiceItem)
        expect(iir.all.count).to eq(23)
      end
    end

    describe '#find_by_id' do
      it 'returns an instance with id matching the one provided' do
        ii = iir.find_by_id(2578)

        expect(ii).to be_an_instance_of(InvoiceItem)
        expect(ii.item_id).to eq(263396209)
      end

      it 'returns nil if no match found' do
        expect(iir.find_by_id(10)).to be_nil
      end
    end

    describe '#find_all_by_item_id' do
      it 'returns Array of instances matching item_id provided' do
        ii = iir.find_all_by_item_id(263396279)

        expect(ii).to be_an_instance_of(Array)
        expect(ii[0]).to be_an_instance_of(InvoiceItem)
        expect(ii.count).to eq(2)
      end

      it 'returns [] if no matches found' do
        ii = iir.find_all_by_item_id(0)

        expect(ii).to eq([])
      end
    end

    describe '#find_all_by_invoice_id' do
      it 'returns Array of instances matching invoice_id provided' do
        ii = iir.find_all_by_invoice_id(74)

        expect(ii).to be_an_instance_of(Array)
        expect(ii[0]).to be_an_instance_of(InvoiceItem)
        expect(ii.count).to eq(6)
      end
    end
  end
end
