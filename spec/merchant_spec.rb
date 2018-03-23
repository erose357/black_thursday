require_relative '../lib/merchant'

RSpec.describe Merchant do
  let (:m) { Merchant.new({id: 100, name: 'Fake Company'}) }

  it 'is a valid instance' do
    expect(m).to be_an_instance_of(Merchant)
  end

  describe 'Attributes' do
    it 'id' do
      expect(m.id).to eq(100)
    end

    it 'name' do
      expect(m.name).to eq('Fake Company')
    end
  end
end
