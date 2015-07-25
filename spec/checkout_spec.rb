require 'checkout'

describe Checkout do
  it "has an empty list of scanned items when initialized" do
    expect(subject.scanned_items).to eq([])
  end

  it "can scan an item passed in from a basket and stores in scanned items" do
    item = double :item, code:"001", name:"Lavendar heart", price: 9.25
    subject.scan(item)
    expect(subject.scanned_items).to eq [["001", "Lavendar heart", 9.25]]
  end

  it "can scan two items passed in from a basket and stores in scanned items" do
    item1 = double :item, code:"001", name:"Lavendar heart", price: 9.25
    item2 = double :item, code:"002", name:"Personalised cufflinks", price: 45.00
    subject.scan(item1)
    subject.scan(item2)
    expect(subject.scanned_items).to eq [["001", "Lavendar heart", 9.25],["002", "Personalised cufflinks", 45.00]]
  end

  it "can calculate the total cost of one item in a basket" do
    item = double :item, code:"001", name:"Lavendar heart", price: 9.25
    subject.scan(item)
    expect(subject.total).to eq 9.25
  end

  it "can calculate the total cost of two items in a basket" do
    item1 = double :item, code:"001", name:"Lavendar heart", price: 9.25
    item2 = double :item, code:"002", name:"Personalised cufflinks", price: 45.00
    subject.scan(item1)
    subject.scan(item2)
    expect(subject.total).to eq 54.25
  end
end