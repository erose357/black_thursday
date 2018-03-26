require 'bigdecimal'
require 'time'

class Item
  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id,
              :parent

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @name = attrs[:name]
    @description = attrs[:description]
    @unit_price = format_price(attrs[:unit_price])
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:updated_at])
    @merchant_id = attrs[:merchant_id].to_i
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

  def unit_price_to_dollars(unit_price)
    unit_price.to_f
  end

  def merchant
    @parent.merchant.find_by_id(self.merchant_id)
  end
end
