require 'checkout'
feature 'user arrives at checkout' do
  before :each do
    @co = Checkout.new
  end
  scenario 'and can have their one item basket processed' do
    item = Item.new('001', 'Lavender heart', 9.25)
    @co.scan(item)
    expect(@co.total).to eq(9.25)
  end
end