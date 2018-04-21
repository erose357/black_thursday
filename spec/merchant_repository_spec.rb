require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  let (:mr) { MerchantRepository.new("spec/fixtures/merchants_fixture.csv", 'parent' ) }

  it 'is a valid instance' do
    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  describe 'Attributes' do
    it 'data' do
      expect(mr.data.length).to eq(13)
      expect(mr.data).to be_an_instance_of(Hash)
    end
  end

  describe 'Instance Methods' do
    describe '#all' do
      it 'returns an array of all Merchant instances' do
        expect(mr.all.length).to eq(13)
        expect(mr.all[0]).to be_an_instance_of(Merchant)
        expect(mr.all).to be_an_instance_of(Array)
      end
    end

    describe '#find_by_id' do
      it 'returns nil if no match found' do
        expect(mr.find_by_id(000)).to be_nil
      end

      it 'returns a matching Merchant instance' do
        expect(mr.find_by_id(12334115).name).to eq('LolaMarleys')
      end
    end

    describe '#find_by_name' do
      it 'returns nil if no match found' do
        expect(mr.find_by_name('nonsense')).to be_nil
      end

      it 'returns a matching Merchant instance if found - case insensitive search' do
        expect(mr.find_by_name('GoldenRayPress')).to be_an_instance_of(Merchant)
        expect(mr.find_by_name('GoldenRayPress').id).to eq(12334135)
      end
    end

    describe '#find_all_by_name' do
      it 'returns [] if no match found' do
        expect(mr.find_all_by_name('test')).to eq([])
      end

      it 'returns all matches of a partial merchant name' do
        expect(mr.find_all_by_name('andi').count).to eq(2)
        expect(mr.find_all_by_name('opin19').count).to eq(3)
        expect(mr.find_all_by_name('o').count).to eq(7)
      end

      it 'returns all matches of a full merchant name' do
        expect(mr.find_all_by_name('BowlsByChris').count).to eq(1)
        expect(mr.find_all_by_name('Shopin1901').count).to eq(3)
      end
    end

    describe '#item_count_by_merchant' do
     #need to decide on a way to handle the relationshihp to 'parent' needed for this test
     skip it 'returns a hash with merchant_id as the key and item count as the value' do
        expect(mr.item_count_by_merchant).to be_an_instance_of(Hash)
        expect(mr.item_count_by_merchant.keys.first).to eq(12334105)
        expect(mr.item_count_by_merchant.values.first).to eq(3)
      end
    end
  end
end
