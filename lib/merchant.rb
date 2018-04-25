class Merchant
  attr_reader :id, :name, :parent

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @name = attrs[:name]
    @parent = parent
  end

  def items
    @parent.items.values.find_all { |i| i.merchant_id == self.id }
  end

  def invoices
    @parent.invoices.values.find_all { |i| i.merchant_id == self.id }
  end

  def customers
    customer_ids = self.invoices.map(&:customer_id).uniq
    customer_ids.map { |c_id| customers_data.find_by_id(c_id) }
  end

  private
    def customers_data
      @parent.parent.customers
    end
end
