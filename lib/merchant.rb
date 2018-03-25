class Merchant
  attr_reader :id, :name

  def initialize(attrs)
    @id = attrs[:id].to_i
    @name = attrs[:name]
  end
end
