require_relative 'item'
require 'csv'
require 'bigdecimal'

class ItemRepository
  attr_reader :data

  def initialize(file_path)
    @data = parse_csv(file_path)
  end

  def parse_csv(file)
    data_hash = {}
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data_hash[row[:id].to_i] = Item.new(Hash[row])
    end
    @data = data_hash
  end
end
