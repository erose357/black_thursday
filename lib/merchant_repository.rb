require_relative 'merchant'
require 'csv'

class MerchantRepository
  attr_reader :data, :parent

  def initialize(file_path, parent)
    @data = parse_csv(file_path)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@data.size} rows>"
  end

  def parse_csv(file)
    data_hash = {}
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data_hash[row[:id].to_i] = Merchant.new(Hash[row], self)
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
    merchant = @data.find { |k,v| v.name.downcase == merchant_name.downcase }
    merchant == nil ? nil : merchant[1]
  end

  def find_all_by_name(merchant_name)
    merchants = @data.select do |k,v|
      v.name.downcase.include?(merchant_name.downcase)
    end
    merchants == {} ? [] : merchants.values
  end

  def items
    @parent.items.data
  end

  def item_count_by_merchant
    @data.map { |k,v| [k, v.items.count.to_f] }.to_h
  end
end
