require 'bigdecimal'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
              :unit_price, :created_at, :updated_at,
              :parent

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @item_id = attrs[:item_id].to_i
    @invoice_id = attrs[:invoice_id].to_i
    @quantity = attrs[:quantity].to_i
    @unit_price = format_price(attrs[:unit_price])
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:updated_at])
    @parent = parent
  end

  def format_time(time_string)
    time_arr = time_string.split(/[-:' ']/)
    Time.utc(time_arr[0], time_arr[1], time_arr[2],
             time_arr[3], time_arr[4], time_arr[5])
  end

  def format_price(price_string)
    to_dollars = price_string.insert(-3, ".")
    BigDecimal.new(to_dollars)
  end
end
