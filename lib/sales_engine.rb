require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices

  def initialize(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants], self)
    @items = ItemRepository.new(file_paths[:items], self)
    @invoices = InvoiceRepository.new(file_paths[:invoices], self)
  end

  def self.from_csv(csv_paths_hash)
    SalesEngine.new(csv_paths_hash)
  end
end
