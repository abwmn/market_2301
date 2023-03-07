require './lib/market.rb'

RSpec.describe Market do
  before(:all) do
    @market = Market.new("South Pearl Street Farmers Market")  
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")  
    @vendor3 = Vendor.new("Palisade Peach Shack")  
    @item1 = Item.new({name: 'Peach', price: "$0.79"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)    
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65) 
  end

  it 'exists' do
    expect(@market).to be_a(Market)
  end

  it 'has attributes' do
    expect(@market.name).to eq('South Pearl Street Farmers Market')
    expect(@market.vendors).to eq([])
  end

  it 'adds and checks vendors' do
    expect(@market.add_vendor(@vendor1)).to eq([@vendor1])
    expect(@market.add_vendor(@vendor2)).to eq([@vendor1, @vendor2])
    expect(@market.add_vendor(@vendor3)).to eq([@vendor1, @vendor2, @vendor3])
    expect(@market.vendor_names).to eq([@vendor1.name, @vendor2.name, @vendor3.name])
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
  end

  it 'displays sorted item list' do
    expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end

  it 'displays total inventory' do
    expect(@market.total_inventory).to be_a(Hash)
    expect(@market.total_inventory[@item1]).to be_a(Hash)
    expect(@market.total_inventory[@item1]).to eq({qty: 100, vendors: [@vendor1, @vendor3]})
    expect(@market.total_inventory[@item2]).to eq({qty: 7, vendors: [@vendor1]})
    expect(@market.total_inventory[@item3]).to eq({qty: 25, vendors: [@vendor2]})
    expect(@market.total_inventory[@item4]).to eq({qty: 50, vendors: [@vendor2]})
  end

  it 'displays overstocked items' do
    expect(@market.overstocked_items).to eq([@item1])
  end

  it 'sells items' do
    expect(@market.sell('fake_item', 1)).to eq(false)
    expect(@market.sell(@item1, 101)).to eq(false)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.sell(@item1, 50)).to eq(true)
    expect(@market.total_inventory[@item1][:qty]).to eq(50)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor3])
    expect(@market.sell(@item1, 48)).to eq(true)
    expect(@market.total_inventory[@item1][:qty]).to eq(2)
    expect(@market.sell(@item1, 2)).to eq(true)
    expect(@market.total_inventory[@item1][:qty]).to eq(0)
    expect(@market.vendors_that_sell(@item1)).to eq([])
  end
end

