require_relative 'item'
require 'csv'
require 'bigdecimal'

class ItemRepository
  attr_reader :data

  def initialize(file_path)
    @data = parse_csv(file_path)
  end

  def inspect
    "#<#{self.class} #{@data.size} rows>"
  end

  def parse_csv(file)
    data_hash = {}
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data_hash[row[:id].to_i] = Item.new(Hash[row])
    end
    @data = data_hash
  end

  def all
    @data.values
  end

  def find_by_id(item_id)
    @data[item_id]
  end

  def find_by_name(item_name)
    @data.values.find { |i| i.name.downcase == item_name.downcase }
  end

  def find_all_with_description(item_description)
    @data.values.find_all { |i| i.description.downcase.include?(item_description.downcase) }
  end

  def find_all_by_price(item_price)
    @data.values.find_all do |i|
      i.unit_price == item_price
    end
      
      #{ |i| i.unit_price == item_price }
  end

  def find_all_by_price_in_range(range)
    @data.values.find_all { |i| range.cover?(i.unit_price.to_f) }
  end

  def find_all_by_merchant_id(merchant_id)
    @data.values.find_all { |i| i if i.merchant_id == merchant_id }
  end
end
