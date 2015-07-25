require 'checkout'

describe Checkout do
  PROMO1 = Proc.new do |scanned_items, item_total|
    scanned_items.map{|x| x[1]}.select{|x| x == "Lavender heart"}.length > 1
  end
  PROMO2 = Proc.new do |item_total|
    item_total > 60
  end
  PROMOTIONAL_RULES = {"promo1":  PROMO1, "promo2": PROMO2}
  subject{ Checkout.new(PROMOTIONAL_RULES) }

  before :each do
    @item1 = double :item, code:"001", name:"Lavender heart", price: 9.25
    @item2 = double :item, code:"002", name:"Personalised cufflinks", price: 45.00
    @item3 = double :item, code:"003", name:"Kids T-shirt", price: 19.95
  end

  it "has an empty list of scanned items when initialized" do
    expect(subject.scanned_items).to eq([])
  end

  it "has promotional rules when initialised" do
    expect(subject.promotional_rules).to eq ({"promo1":  PROMO1, "promo2": PROMO2})
  end

  it "can scan an item passed in from a basket and stores in scanned items" do
    subject.scan(@item1)
    expect(subject.scanned_items).to eq [["001", "Lavender heart", 9.25]]
  end

  it "can scan two items passed in from a basket and stores in scanned items" do
    subject.scan(@item1)
    subject.scan(@item2)
    expect(subject.scanned_items).to eq [["001", "Lavender heart", 9.25],["002", "Personalised cufflinks", 45.00]]
  end

  it "can calculate the total cost of one item in a basket" do
    subject.scan(@item1)
    expect(subject.total).to eq 9.25
  end

  it "can calculate the total cost of two items in a basket" do
    subject.scan(@item1)
    subject.scan(@item2)
    expect(subject.total).to eq 54.25
  end

  it "can apply discount of 10% when spend over £60" do
    subject.scan(@item1)
    subject.scan(@item2)
    subject.scan(@item3)
    expect(subject.total).to eq 66.78
  end

  it "can apply discount when buy 2 or more Lavender hearts" do
    subject.scan(@item1)
    subject.scan(@item1)
    subject.scan(@item3)
    expect(subject.total).to eq 36.95
  end
end