require_relative 'invoice_item'
require 'csv'

class InvoiceItemRepository
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
      data_hash[row[:id].to_i] = InvoiceItem.new(Hash[row], self)
    end
    @data = data_hash
  end

  def all
    @data.values
  end

  def find_by_id(invoice_item_id)
    @data[invoice_item_id]
  end

  def find_all_by_item_id(item_id)
    @data.values.find_all { |ii| ii if ii.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @data.values.find_all { |ii| ii if ii.invoice_id == invoice_id }
  end
end
