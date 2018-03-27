require_relative 'invoice'
require 'csv'

class InvoiceRepository
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
      data_hash[row[:id].to_i] = Invoice.new(Hash[row], self)
    end
    @data = data_hash
  end

  def merchant
    @parent.merchants.data
  end

  def all
    @data.values
  end

  def find_by_id(invoice_id)
    @data[invoice_id]
  end

  def find_all_by_customer_id(customer_id)
    @data.values.find_all { |inv| inv.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @data.values.find_all { |inv| inv.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @data.values.find_all { |inv| inv.status == status }
  end

  def invoice_count_by_day
    days_hash = {}
    @data.values.each do |inv|
      if days_hash.keys.include?(inv.created_at.strftime('%A'))
        days_hash[inv.created_at.strftime('%A')] += 1
      else
        days_hash[inv.created_at.strftime('%A')] = 1
      end
    end
    return days_hash
  end
end
