require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  let (:in_r) { InvoiceRepository.new('spec/fixtures/invoices_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(in_r).to be_an_instance_of(InvoiceRepository)
  end
end
