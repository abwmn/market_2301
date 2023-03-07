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

  it 'its vendors still calculate potential revenue' do
    expect(@vendor1.potential_revenue).to eq(31.15)
    #changed item1 price to make sure method can handle odd prices
    expect(@vendor2.potential_revenue).to eq(345.00)
    expect(@vendor3.potential_revenue).to eq(51.35)
  end
end

