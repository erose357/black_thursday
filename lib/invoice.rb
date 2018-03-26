require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @customer_id = attrs[:customer_id].to_i
    @merchant_id = attrs[:merchant_id].to_i
    @status = attrs[:status]
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:created_at])
    @parent = parent
  end

  def format_time(time_string)
    time_arr = time_string.split('-')
    Time.utc(time_arr[0], time_arr[1], time_arr[2])
  end

end

