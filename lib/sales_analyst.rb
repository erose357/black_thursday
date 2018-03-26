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
    item_counts = merchant_item_count
    Math.sqrt((item_counts.values.map { |n| (n-mean) ** 2 }.reduce(&:+))/(item_counts.values.length - 1)).round(2)
  end

  private
    def merchant_item_count
      @engine.merchants.item_count_by_merchant
    end
end
