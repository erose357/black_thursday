require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @customer_id = attrs[:customer_id].to_i
    @merchant_id = attrs[:merchant_id].to_i
    @status = attrs[:status].to_sym
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:updated_at])
    @parent = parent
  end

  def format_time(time_string)
    time_arr = time_string.split('-')
    Time.new(time_arr[0], time_arr[1], time_arr[2])
  end

  def merchant
    @parent.merchant[self.merchant_id]
  end

  def is_paid_in_full?
    results = transactions.find_all_by_invoice_id(self.id).map(&:result)
    results.include?('success') ? true : false
  end

  def total
    items = invoice_items.find_all_by_invoice_id(self.id)
    items.map { |i| i.quantity * i.unit_price }.reduce(:+)
  end

  def items
    item_ids = invoice_items.find_all_by_invoice_id(self.id).map(&:item_id)
    item_ids.map{ |i_id| @parent.parent.items.find_by_id(i_id) }
  end

  private
    def transactions
      @parent.parent.transactions
    end

    def invoice_items
      @parent.parent.invoice_items
    end
end

