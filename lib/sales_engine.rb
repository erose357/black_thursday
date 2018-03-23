require 'merchant_repository'

class SalesEngine
  attr_reader :merchants

  def initialize(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants]) 
  end

  def self.from_csv(csv_paths_hash)
    SalesEngine.new(csv_paths_hash)
  end
end
