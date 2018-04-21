require_relative '../lib/invoice_item'

RSpec.describe InvoiceItem do
  let (:ii) { InvoiceItem.new({ :id => '6',
                                :item_id => '7',
                                :invoice_id => '8',
                                :quantity => '1',
                                :unit_price => '1099',
                                :created_at => '2012-03-27 14:54:09 UTC',
                                :updated_at => '2012-03-27 14:54:09 UTC'}, 'parent') }

  it 'is a valid instance' do
    expect(ii).to be_an_instance_of(InvoiceItem)
  end

  describe 'Attributes' do
    describe '@id' do
      it 'returns the id' do
        expect(ii.id).to eq(6)
        expect(ii.id).to be_an_instance_of(Integer)
      end
    end

    describe '@item_id' do
      it 'returns the item_id' do
        expect(ii.item_id).to eq(7)
        expect(ii.item_id).to be_an_instance_of(Integer)
      end
    end
    
    describe '@invoice_id' do
      it 'returns the invoice_id' do
        expect(ii.invoice_id).to eq(8)
        expect(ii.invoice_id).to be_an_instance_of(Integer)
      end
    end

    describe '@quantity' do
      it 'returns the quantity' do
        expect(ii.quantity).to eq(1)
        expect(ii.quantity).to be_an_instance_of(Integer)
      end
    end

    describe '@unit_price' do
      it 'returns the unit_price' do
        expect(ii.unit_price.to_f).to eq(10.99)
        expect(ii.unit_price).to be_an_instance_of(BigDecimal)
      end
    end

    describe '@created_at' do
      it 'returns the created_at time instance' do
        expect(ii.created_at.to_s).to eq('2012-03-27 14:54:09 UTC')
        expect(ii.created_at).to be_an_instance_of(Time)
      end
    end

    describe '@updated_at' do
      it 'returns the updated_at time instance' do
        expect(ii.updated_at.to_s).to eq('2012-03-27 14:54:09 UTC')
        expect(ii.updated_at).to be_an_instance_of(Time)
      end
    end

    describe '#unit_price_to_dollars' do
      it 'returns the price of the invoice item in $ as Float' do
        expect(ii.unit_price_to_dollars).to be_an_instance_of(Float)
        expect(ii.unit_price_to_dollars).to eq(10.99)
      end
    end
  end
end
