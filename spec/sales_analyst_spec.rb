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
      end
    end
  end
end
