require_relative '../lib/sales_engine'

RSpec.describe SalesEngine do
  let (:file_paths) { { :merchants => 'spec/fixtures/merchants_fixture.csv',
                        :items => 'spec/fixtures/items_fixture.csv',
                        :invoices => 'spec/fixtures/invoices_fixture.csv'
  } }

  let (:se) { SalesEngine.from_csv(file_paths) }

  it 'is a valid instance' do
    expect(se).to be_an_instance_of(SalesEngine)
  end

  describe 'Attributes' do
    describe 'merchants' do
      it 'can access merchants attribute' do
        expect(se.merchants).to be_an_instance_of(MerchantRepository)
      end
    end

    describe 'items' do
      it 'can access items attribute' do
        expect(se.items).to be_an_instance_of(ItemRepository)
      end
    end

    describe 'invoices' do
      it 'can access invoices attribute' do
        expect(se.invoices).to be_an_instance_of(InvoiceRepository)
      end
    end
  end

  describe 'Relationships' do
    describe 'merchant#items' do
      it 'returns an Array of all items matching the merchant_id provided' do
        merchant = se.merchants.find_by_id(12334105)

        expect(merchant.items).to be_an_instance_of(Array)
        expect(merchant.items[0]).to be_an_instance_of(Item)
        expect(merchant.items.map(&:id)).to eq([263396209, 263500440, 263501394])
      end
    end

    describe 'item#merchant' do
      it "returns the merchant instance matching the item's merchant_id" do
        item = se.items.find_by_id(263396209)

        expect(item.merchant).to be_an_instance_of(Merchant)
        expect(item.merchant.id).to eq(12334105)
      end
    end
  end
end
