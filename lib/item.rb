class Item
  attr_reader :name, :price
  
  def initialize(deets)
    @name = deets[:name]
    @price = deets[:price]
  end
  
end
