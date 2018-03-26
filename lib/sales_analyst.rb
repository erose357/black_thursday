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
      @engine.merchants.data[k] if v > (mean + std_deviation)
    end.compact
  end

  private
    def merchant_item_count
      @engine.merchants.item_count_by_merchant
    end
end
