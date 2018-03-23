require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  let (:ir) { ItemRepository.new }

  it 'is a valid instance' do
    expect(ir).to be_an_instance_of(ItemRepository)
  end

  describe 'Attributes' do
    it 'data' do
      expect(ir.data.length).to eq(10)
      expect(ir.data).to be_an_instance_of(Hash)
    end
  end
end
