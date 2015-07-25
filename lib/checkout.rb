require_relative 'item'
class Checkout
  attr_reader :scanned_items, :promotional_rules

  PROMO1 = Proc.new do |scanned_items, item_total|
    scanned_items.map{|x| x[1]}.select{|x| x == "Lavender heart"}.length > 1
  end
  PROMO2 = Proc.new do |item_total|
    item_total > 60
  end
  PROMOTIONAL_RULES = {"promo1":  PROMO1, "promo2": PROMO2}

  def initialize(promotional_rules)
    @scanned_items = []
    @promotional_rules = promotional_rules
  end

  def scan(item)
    @scanned_items << [item.code, item.name, item.price]
  end

  def total
    price_index = 2
    item_total = @scanned_items.map{|item|item.select.with_index{|_,i| i == price_index}}.flatten.reduce(:+)
    if @promotional_rules[:promo1].call(@scanned_items, item_total)
      item_total -= ((9.25 - 8.50) * @scanned_items.map{|x| x[1]}.select{|x| x == "Lavender heart"}.length)
    end
    if @promotional_rules[:promo2].call(item_total)
      item_total -= (item_total * 0.1)
    end
    item_total.round(2)
  end
end