require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

RSpec.describe SalesAnalyst do
  let (:file_paths) { 
    { :merchants => 'spec/fixtures/merchants_fixture.csv',
      :items => 'spec/fixtures/items_fixture.csv',
      :invoices => 'spec/fixtures/invoices_fixture.csv',
      :invoice_items => 'spec/fixtures/invoice_items_fixture.csv',
      :transactions => 'spec/fixtures/transactions_fixture.csv',
      :customers => 'spec/fixtures/customers_fixture.csv'
    }
  }
  let (:file_paths_2) {
    { :merchants => 'data/merchants.csv',
      :items => 'data/items.csv',
      :invoices => 'data/invoices.csv',
      :invoice_items => 'data/invoice_items.csv',
      :transactions => 'data/transactions.csv',
      :customers => 'data/customers.csv'
    }
  }

  let (:se) { SalesEngine.from_csv(file_paths) }
  let (:se_2) { SalesEngine.from_csv(file_paths_2) }
  let (:sa) { SalesAnalyst.new(se) }
  let (:sa_2) { SalesAnalyst.new(se_2) }

  it 'is a valid instance ' do
    expect(sa).to be_an_instance_of(SalesAnalyst)
  end

  context 'Attributes' do
    describe '@engine' do
      it 'is a valid instance of SalesEngine' do
        expect(sa.engine).to be_an_instance_of(SalesEngine)
      end
    end
  end

  context 'Instance methods' do
    describe '#average_items_per_mechant' do
      it 'returns an average of items per merchant' do
        expect(sa.average_items_per_merchant).to eq(0.31)
      end
    end

    describe '#average_items_per_merchant_standard_deviation' do
      it 'returns the standard deviation of average items per merchant' do
        expect(sa_2.average_items_per_merchant_standard_deviation).to eq(3.26)
        expect(sa_2.average_items_per_merchant_standard_deviation).to be_an_instance_of(Float)
      end
    end

    describe '#merchants_with_high_item_count' do
      it 'returns merchants more than one standard deviation above the average number of products' do
        expect(sa_2.merchants_with_high_item_count.length).to eq(52)
        expect(sa_2.merchants_with_high_item_count[0]).to be_an_instance_of(Merchant)
      end
    end

    describe '#average_item_price_for_merchant' do
      it 'returns average item price for merchant_id supplied' do
        expect(sa.average_item_price_for_merchant(12334105).to_f.round(2)).to eq(16.66)
        expect(sa.average_item_price_for_merchant(12334105)).to be_an_instance_of(BigDecimal)
      end
    end

    describe '#average_average_price_per_merchant' do
      it 'returns the average of all average item prices' do
        expect(sa_2.average_average_price_per_merchant.to_f).to eq(350.29)
        expect(sa_2.average_average_price_per_merchant).to be_an_instance_of(BigDecimal)
      end
    end

    describe '#golden_items' do
      it 'returns items that are two standard deviations above the average item price' do
        expect(sa_2.golden_items[0]).to be_an_instance_of(Item)
        expect(sa_2.golden_items).to be_an_instance_of(Array)
        expect(sa_2.golden_items.length).to eq(5)
      end
    end

    describe '#average_invoices_per_merchant' do
      it 'returns the average invoices per merchant' do
        expect(sa.average_invoices_per_merchant).to eq(3.23)
        expect(sa.average_invoices_per_merchant).to be_an_instance_of(Float)
      end
    end

    describe '#average_invoices_per_merchant_standard_deviation' do
      it 'returns the standard deviation of invoices per merchant' do
        expect(sa.average_invoices_per_merchant_standard_deviation).to eq(3.35)
        expect(sa.average_invoices_per_merchant_standard_deviation).to be_an_instance_of(Float)
      end
    end

    describe '#top_merchants_by_invoice_count' do
      it 'returns the merchants who are two standard deviations above the mean in invoice count' do
        top = sa.top_merchants_by_invoice_count

        expect(top).to be_an_instance_of(Array)
        expect(top[0]).to be_an_instance_of(Merchant)
        expect(top[0].id).to eq(12334113)
        expect(top.length).to eq(1)
      end
    end

    describe '#bottom_merchants_by_invoice_count' do
      it 'returns merchants who are two standard deviations below the mean' do
        bottom = sa_2.bottom_merchants_by_invoice_count

        expect(bottom).to be_an_instance_of(Array)
        expect(bottom[0]).to be_an_instance_of(Merchant)
        expect(bottom.length).to eq(4)
      end
    end

    describe '#top_days_by_invoice_count' do
      it 'returns Array of days of the week that invoices are created more than one standard deviation above the mean' do
        days = sa.top_days_by_invoice_count

        expect(days).to be_an_instance_of(Array)
        expect(days[0]).to eq('Monday')
      end
    end

    describe '#invoice_status' do
      it 'returns the percentage of invoices with the supplied status' do
        expect(sa.invoice_status(:pending)).to be_an_instance_of(Float)
        expect(sa.invoice_status(:pending)).to eq(16.67)
        expect(sa.invoice_status(:returned)).to eq(14.29)
        expect(sa.invoice_status(:shipped)).to eq(69.05)
      end
    end
  end

  context 'Merchant Analytics' do
    describe '#total_revenue_by_date' do
      it 'returns total revenue for given date' do
        expect(sa_2.total_revenue_by_date(Time.parse('2009-02-07')).to_f).to eq(21067.77)
      end
    end

    describe '#top_revenue_earners' do
      it 'returns by default the top 20 merchants ranked by revenue if no argument is given' do
        skip "need to update fixtures with all invoices related to merchants"
        revenue = sa.top_revenue_earners

        expect(revenue).to be_an_instance_of(Array)
        expect(revenue[0]).to be_an_instance_of(Merchant)
        expect(revenue.count).to eq(4)
        expect(revenue[0].id).to eq(12334105)
      end

      it 'returns the number of merchants specified' do
        skip "need to update fixtures with all invoices related to merchants"
        revenue = sa.top_revenue_earners(2)

        expect(revenue).to be_an_instance_of(Array)
        expect(revenue[0]).to be_an_instance_of(Merchant)
        expect(revenue.count).to eq(2)
        expect(revenue[1].id).to eq(12334123)
      end
    end

    describe '#merchants_ranked_by_revenue' do
      it 'returns the merchants ranked by total revenue' do
        skip "temp skipped to save test suite run time"
        ranked = sa_2.merchants_ranked_by_revenue

        expect(ranked).to be_an_instance_of(Array)
        expect(ranked.first.id).to eq(12334634)
        expect(ranked.last.id).to eq(12336175)
        expect(ranked.first).to be_an_instance_of(Merchant)
      end
    end

    describe '#merchants_with_pending_invoices' do
       it 'returns merchants with pending invoices' do
         pending = sa.merchants_with_pending_invoices

         expect(pending).to be_an_instance_of(Array)
         expect(pending.first).to be_an_instance_of(Merchant)
         expect(pending.count).to eq(5)
       end
    end
  end
end
