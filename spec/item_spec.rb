require 'item'

describe Item do
  it "has a code, name and price when initialised" do
    item = Item.new "001", "Lavender heart", 9.25
    expect(item.code).to eq "001"
    expect(item.name).to eq "Lavender heart"
    expect(item.price).to eq 9.25
  end
end

