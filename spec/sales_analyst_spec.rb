require_relative '../lib/sales_analyst'
RSpec.describe SalesAnalyst do
  let (:file_paths) { 
    { :merchants => 'spec/fixtures/merchants_fixture.csv', 
      :items => 'spec/fixtures/items_fixture.csv' 
    }
  }
  let (:file_paths_2) {
    { :merchants => 'data/merchants.csv', 
      :items => 'data/items.csv' 
    }
  }

  let (:se) { SalesEngine.from_csv(file_paths) }
  let (:se_2) { SalesEngine.from_csv(file_paths_2) }
  let (:sa) { SalesAnalyst.new(se) }
  let (:sa_2) { SalesAnalyst.new(se_2) }

  it 'is a valid instance ' do
    expect(sa).to be_an_instance_of(SalesAnalyst)
  end

  describe 'Attributes' do
    describe '@engine' do
      it 'is a valid instance of SalesEngine' do
        expect(sa.engine).to be_an_instance_of(SalesEngine)
      end
    end
  end

  describe 'Instance methods' do
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
      it 'returns the average of all average ite prices' do
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
  end
end
