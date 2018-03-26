class Merchant
  attr_reader :id, :name, :parent

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @name = attrs[:name]
    @parent = parent
  end

  def items
    @parent.items.find_all { |i| i.merchant_id == self.id }
  end
end
