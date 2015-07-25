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

  scenario 'and can have multiple items in basket processed' do
    item1 = Item.new('001', 'Lavender heart', 9.25)
    item2 = Item.new('002', 'Personalised cufflinks', 45.00)
    @co.scan(item1)
    @co.scan(item2)
    expect(@co.total).to eq(54.25)
  end
end