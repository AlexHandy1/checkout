require 'checkout'
feature 'user arrives at checkout' do
  before :each do
    PROMO1 = Proc.new do |scanned_items, item_total|
      scanned_items.map{|x| x[1]}.select{|x| x == "Lavender heart"}.length > 1
    end

    PROMO2 = Proc.new do |item_total|
      item_total > 60
    end
    PROMOTIONAL_RULES = {"promo1":  PROMO1, "promo2": PROMO2}
    @co = Checkout.new (PROMOTIONAL_RULES)
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

  scenario 'and can have items with multiple discounts (> £60 and 2 or more Lavender hearts) processed' do
    item1 = Item.new('001', 'Lavender heart', 9.25)
    item2 = Item.new('002', 'Personalised cufflinks', 45.00)
    item3 = Item.new('003', 'Kids T-Shirt', 19.95)
    @co.scan(item1)
    @co.scan(item1)
    @co.scan(item2)
    @co.scan(item3)
    expect(@co.total).to eq(73.76)
  end
end