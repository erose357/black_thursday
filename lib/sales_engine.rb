require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants], self)
    @items = ItemRepository.new(file_paths[:items], self)
  end

  def self.from_csv(csv_paths_hash)
    SalesEngine.new(csv_paths_hash)
  end
end
