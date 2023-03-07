require './lib/vendor.rb'

RSpec.describe Item do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  it 'exists' do
    expect(@vendor).to be_a(Vendor)
  end

  it 'has attributes' do
    expect(@vendor.name).to eq('Rocky Mountain Fresh')
    expect(@vendor.inventory).to eq({})
  end

  it 'checks and adds stock' do
    expect(@vendor.check_stock(@item1)).to eq(0)
    expect(@vendor.stock(@item1, 30)).to eq(30)
    expect(@vendor.check_stock(@item1)).to eq(30)
    expect(@vendor.stock(@item1, 25)).to eq(55)
    expect(@vendor.inventory).to eq({@item1 => 55})
    @vendor.stock(@item2, 5)
    expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 5})
  end

  it 'calculates potential revenue' do
    @vendor.stock(@item1, 28)
    @vendor.stock(@item2, 20)
    expect(@vendor.potential_revenue).to eq(31)
    expect(@item1.price).to eq('$0.75')
  end
end

