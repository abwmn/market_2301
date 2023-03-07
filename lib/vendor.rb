class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, qty)
    @inventory[item] += qty
  end

  def potential_revenue
    total = 0
    @inventory.each do |item, qty|
      # require 'pry'; binding.pry
      price = item.price.delete('$').to_f
      total += (price * qty)
    end
    total.round(2)
  end
end
