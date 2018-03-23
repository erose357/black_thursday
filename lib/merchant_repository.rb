require 'merchant'
require 'csv'

class MerchantRepository
  attr_reader :data

  def initialize(file_path)
    @data = parse_csv(file_path)
  end

  def parse_csv(file)
    data_hash = {}
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data_hash[row[:id].to_i] = Merchant.new({:id => row[:id].to_i, :name => row[:name]})
    end
    @data = data_hash
  end

  def all
    @data.values
  end

  def find_by_id(merchant_id)
   @data[merchant_id] ? @data[merchant_id] : nil
  end

  def find_by_name(merchant_name)
    name = merchant_name.downcase
    merchant = @data.find { |k,v| v.name.downcase == name }
    merchant == nil ? nil : merchant[1]
  end
end
