require_relative '../lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let (:iir) { InvoiceItemRepository.new('spec/fixtures/invoice_items_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(iir).to be_an_instance_of(InvoiceItemRepository)
  end
end
