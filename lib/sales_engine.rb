require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def initialize(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants], self)
    @items = ItemRepository.new(file_paths[:items], self)
    @invoices = InvoiceRepository.new(file_paths[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(file_paths[:invoice_items], self)
    @transactions = TransactionRepository.new(file_paths[:transactions], self)
    @customers = CustomerRepository.new(file_paths[:customers], self)
  end

  def self.from_csv(csv_paths_hash)
    SalesEngine.new(csv_paths_hash)
  end
end
