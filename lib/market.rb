class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end
  
  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.filter { |vendor|
      vendor.check_stock(item) > 0
    }.map { |vendor| vendor }
  end

  def sorted_item_list
    @vendors.map { |vendor|
      vendor.inventory.keys.map { |item| item.name }
    }.flatten.uniq.sort
  end

  def total_inventory
    inventory = Hash.new{|h,k| h[k] = {qty: 0, vendors: []}}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, qty|
        inventory[item][:qty] += qty
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end

  def overstocked_items
    total_inventory.filter { |_, info| 
      info[:qty] > 50 && info[:vendors].length > 1
    }.map { |item, _| item }
  end

  def sell(item, qty)
    return false if total_inventory[item][:qty] < qty
    remaining = qty
    vendors_that_sell(item).each do |vendor|
      available = vendor.inventory[item] < remaining ? vendor.inventory[item] : remaining
      vendor.inventory[item] -= available
      remaining -= available
      break if remaining == 0
    end
    true
  end
end