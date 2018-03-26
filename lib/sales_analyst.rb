class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    item_counts = merchant_item_count
    (item_counts.values.reduce(&:+)/item_counts.values.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    item_count = merchant_item_count
    Math.sqrt((item_count.values.map do |n|
      ((n-mean) ** 2)
    end.reduce(&:+))/(item_count.values.length - 1)).round(2)
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

  private
    def merchants
      @engine.merchants
    end

    def merchant_item_count
      merchants.item_count_by_merchant
    end
end
