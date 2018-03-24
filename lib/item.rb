class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(attrs)
    @id = attrs[:id].to_i
    @name = attrs[:name]
    @description = attrs[:description]
    @unit_price = BigDecimal.new(attrs[:unit_price], 4)
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:updated_at])
    @merchant_id = attrs[:merchant_id].to_i
  end

  def format_time(time_string)
    time_arr = time_string.split(/[-:' ']/)
    Time.utc(time_arr[0], time_arr[1], time_arr[2], time_arr[3], time_arr[4], time_arr[5])
  end
end
