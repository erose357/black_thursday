class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    average(merchant_item_count.values)
  end

  def average_invoices_per_merchant
    average(merchant_invoice_count.values)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    item_count = merchant_item_count
    standard_deviation(item_count.values, mean)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    invoice_count = merchant_invoice_count
    standard_deviation(invoice_count.values, mean)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_deviation = average_items_per_merchant_standard_deviation
    item_count = merchant_item_count
    item_count.map do |k,v|
      merchants.data[k] if v > (mean + std_deviation)
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = merchants.data[merchant_id]
    (merchant.items.reduce(BigDecimal.new(0)) do |sum, i|
      sum + (i.unit_price)
    end / merchant.items.length).round(2)
  end

  def average_average_price_per_merchant
    ((merchants.data.values.map do |m|
      average_item_price_for_merchant(m.id)
    end.reduce(&:+))/merchants.data.values.length).round(2)
  end

  def golden_items
    item_prices = items.data.values
    mean = average_average_price_per_merchant
    std_deviation = standard_deviation(item_prices.map(&:unit_price), mean)
    item_prices.map do |i|
      i if i.unit_price > ((std_deviation * 2) + mean)
    end.compact
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    invoice_count = merchant_invoice_count
    std_deviation = standard_deviation(invoice_count.values, mean)
    invoice_count.map do |k,v|
      k if v > (std_deviation * 2) + mean
    end.compact
  end

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    invoice_count = merchant_invoice_count
    std_deviation = standard_deviation(invoice_count.values, mean)
    invoice_count.map do |k,v|
      k if v < mean - (std_deviation * 2)
    end.compact
  end

  def top_days_by_invoice_count
    invoice_count = invoices.invoice_count_by_day
    mean = average(invoices.invoice_count_by_day.values)
    std_dev = standard_deviation(invoices.invoice_count_by_day.values, mean)
    invoice_count.map do |k,v|
      k if v > std_dev + mean
    end.compact
  end

  def invoice_status(status)
    total = invoices.data.values.reduce(0) do |m, n|
      n.status == status ? m + 1 : m + 0
    end
    return ((total.to_f / invoices.data.values.length) * 100).round(2)
  end

  private
    def merchants
      @engine.merchants
    end

    def items
      @engine.items
    end

    def invoices
      @engine.invoices
    end

    def transactions
      @engine.transactions
    end

    def merchant_item_count
      merchants.item_count_by_merchant
    end

    def merchant_invoice_count
      merchants.invoice_count_by_merchant
    end

    def standard_deviation(arr, mean)
      Math.sqrt((arr.map do |n|
        ((n - mean) ** 2)
      end.reduce(&:+))/(arr.length - 1)).round(2)
    end

    def average(arr)
      (arr.reduce(&:+)/arr.length).round(2)
    end
end
