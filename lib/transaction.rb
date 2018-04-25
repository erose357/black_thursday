class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at, :parent

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @invoice_id = attrs[:invoice_id].to_i
    @credit_card_number = attrs[:credit_card_number].to_i
    @credit_card_expiration_date = attrs[:credit_card_expiration_date]
    @result = attrs[:result]
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:updated_at])
    @parent = parent
  end

  def format_time(time_string)
    time_arr = time_string.split(/[-:' ']/)
    Time.utc(time_arr[0], time_arr[1], time_arr[2],
             time_arr[3], time_arr[4], time_arr[5])
  end

  def invoice
    invoices_data.find_by_id(self.invoice_id)
  end

  private
    def invoices_data
      @parent.parent.invoices
    end
end
