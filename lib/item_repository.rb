require_relative 'item'

class ItemRepository
  
  def initialize(file_path)
    @data = parse_csv(file_path)
  end
end
