require 'merchant_repository'

RSpec.describe MerchantRepository do
  let (:mr) { MerchantRepository.new("spec/fixtures/merchants_fixture.csv") }

  it 'is a valid instance' do
    expect(mr).to be_an_instance_of(MerchantRepository)
  end

  describe 'Attributes' do
    it 'data' do
      expect(mr.data.length).to eq(10)
      expect(mr.data).to be_an_instance_of(Hash)
    end
  end

  describe 'Instance Methods' do
    describe '#all' do
      it 'returns an array of all Merchant instances' do
        expect(mr.all.length).to eq(10)
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
  end
end
