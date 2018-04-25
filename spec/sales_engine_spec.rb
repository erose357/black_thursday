require_relative '../lib/sales_engine'

RSpec.describe SalesEngine do
  let (:file_paths) { { :merchants => 'spec/fixtures/merchants_fixture.csv',
                        :items => 'spec/fixtures/items_fixture.csv',
                        :invoices => 'spec/fixtures/invoices_fixture.csv',
                        :invoice_items => 'spec/fixtures/invoice_items_fixture.csv',
                        :transactions => 'spec/fixtures/transactions_fixture.csv',
                        :customers => 'spec/fixtures/customers_fixture.csv'
  } }

  let (:se) { SalesEngine.from_csv(file_paths) }

  it 'is a valid instance' do
    expect(se).to be_an_instance_of(SalesEngine)
  end

  context 'Attributes' do
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

    describe 'invoice_items' do
      it 'can access invoice_items attribute' do
        expect(se.invoice_items).to be_an_instance_of(InvoiceItemRepository)
      end
    end

    describe 'transactions' do
      it 'can access transactions attribute' do
        expect(se.transactions).to be_an_instance_of(TransactionRepository)
      end
    end

    describe 'customers' do
      it 'can access customers attribute' do
        expect(se.customers).to be_an_instance_of(CustomerRepository)
      end
    end
  end

  context 'Relationships' do
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

    describe 'merchant#invoices' do
      it 'returns the invoices associated with merchant_id provided' do
        merchant = se.merchants.find_by_id(12334105)

        expect(merchant.invoices).to be_an_instance_of(Array)
        expect(merchant.invoices[0]).to be_an_instance_of(Invoice)
        expect(merchant.invoices[0].id).to eq(74)
        expect(merchant.invoices.count).to eq(5)
      end
    end

    describe 'invoice#merchant' do
      it 'returns the merchant associated with the inovice_id provided' do
        invoice = se.invoices.find_by_id(602)

        expect(invoice.merchant).to be_an_instance_of(Merchant)
        expect(invoice.merchant.id).to eq(12334123)
      end
    end
  end

  context 'Business Intelligence' do
    describe 'invoice#is_paid_in_full?' do
      it 'returns all items related to the invoice' do
        invoice_1 = se.invoices.find_by_id(1372)
        invoice_2 = se.invoices.find_by_id(1963)

        expect(invoice_1.is_paid_in_full?).to eq(false)
        expect(invoice_2.is_paid_in_full?).to eq(true)
      end
    end

    describe 'invoice#total' do
      it 'returns the total dollar amount for invoice if paid in full' do
        invoice_1 = se.invoices.find_by_id(74)

        expect(invoice_1.total.to_f).to eq(14496.62)
      end
    end
  end
end
