require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  let (:ir) { ItemRepository.new('spec/fixtures/items_fixture.csv') }

  it 'is a valid instance' do
    expect(ir).to be_an_instance_of(ItemRepository)
  end

  describe 'Attributes' do
    it 'data' do
      expect(ir.data.length).to eq(7)
      expect(ir.data).to be_an_instance_of(Hash)
    end
  end
end
