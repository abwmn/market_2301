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
    names = []
    @vendors.each do |vendor|
      names << vendor.name
    end
    names
  end

  def vendors_that_sell(item)
    vendors = []
    @vendors.each do |vendor|
      vendors << vendor if vendor.check_stock(item) > 0
    end
    vendors
  end

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |item|
        items << item.name
      end
    end
    items.uniq.sort
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
end
