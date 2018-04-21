require_relative 'customer'
require 'csv'

class CustomerRepository
  attr_reader :data, :parent

  def initialize(file_path, parent)
    @data = parse_csv(file_path)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{data.size} rows>"
  end

  def parse_csv(file)
    data_hash = {}
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data_hash[row[:id].to_i] = Customer.new(Hash[row], self)
    end
    @data = data_hash
  end

  def all
    @data.values
  end

  def find_by_id(customer_id)
    @data[customer_id]
  end
end
