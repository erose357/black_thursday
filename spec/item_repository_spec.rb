require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  let (:ir) { ItemRepository.new('spec/fixtures/items_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(ir).to be_an_instance_of(ItemRepository)
  end

  describe 'Attributes' do
    it 'data' do
      expect(ir.data.length).to eq(16)
      expect(ir.data).to be_an_instance_of(Hash)
    end
  end

  describe 'Instance methods' do
    describe '#all' do
      it 'returns an Array of all Item instances'do
        expect(ir.all).to be_an_instance_of(Array)
        expect(ir.all.count).to eq(16)
        expect(ir.all[1]).to be_an_instance_of(Item) 
      end
    end
    
    describe '#find_by_id' do
      it 'returns an instance of Item matching the id provided' do
        find = ir.find_by_id(263395617)

        expect(find).to be_an_instance_of(Item)
        expect(find.name).to eq('Glitter scrabble frames')
      end

      it 'returns nil if no matching Item instance found' do
        find = ir.find_by_id(0)

        expect(find).to be_nil
      end
    end

    describe '#find_by_name' do
      it 'returns a matching instance of Item after case insensitive search' do
        find = ir.find_by_name('Free standing Woden letters')

        expect(find).to be_an_instance_of(Item)
        expect(find.id).to eq(263396013)
        expect(find.description).to eq("Free standing wooden letters\n\n15cm\n\nAny colours")
      end

      it 'returns nil if no matching record found' do
        find = ir.find_by_name(' ')

        expect(find).to be_nil
      end
    end

    describe '#find_all_with_description' do
      it 'returns an Array of Item instances matching the String supplied - case insensitive' do
        find = ir.find_all_with_description("Almost every social icon on the planet earth")

        expect(find).to be_an_instance_of(Array)
        expect(find[0]).to be_an_instance_of(Item)
      end

      it 'returns [] if no matches found' do
        find = ir.find_all_with_description("11111111111")

        expect(find).to eq([]) 
      end
    end

    describe '#find_all_by_price' do
      it 'returns an Array of Item instances matching the price supplied' do
        find = ir.find_all_by_price(BigDecimal.new('149.00'))
        find_2 = ir.find_all_by_price(BigDecimal.new('7.00'))

        expect(find).to be_an_instance_of(Array)
        expect(find.count).to eq(2)
        expect(find[0]).to be_an_instance_of(Item)
        expect(find[0].unit_price.to_f).to eq(149.00)
        expect(find_2).to be_an_instance_of(Array)
        expect(find_2.count).to eq(1)
        expect(find_2[0]).to be_an_instance_of(Item)
        expect(find_2[0].unit_price.to_f).to eq(7.00)
      end

      it 'returns [] if no matches found' do
        find = ir.find_all_by_price(0)

        expect(find).to eq([]) 
      end
    end

    describe '#find_all_by_price_in_range' do
      it 'returns Item instances within the supplied range' do
        find = ir.find_all_by_price_in_range((0..100))

        expect(find).to be_an_instance_of(Array)
        expect(find[0]).to be_an_instance_of(Item)
        expect(find.count).to eq(12)
      end

      it 'returns [] if no matches found' do
        find = ir.find_all_by_price_in_range((0..5))

        expect(find).to eq([])
      end
    end

    describe '#find_all_by_merchant_id' do
      it 'returns an Array of Item instances matching the merchant_id supplied' do
        find = ir.find_all_by_merchant_id(12334185)

        expect(find).to be_an_instance_of(Array)
        expect(find.count).to eq(3)
        expect(find.map(&:id)).to eq([263395617, 263395721, 263396013])
      end

      it 'returns [] if no matches found' do
        find = ir.find_all_by_merchant_id(0)

        expect(find).to eq([])
      end
    end
  end
end
