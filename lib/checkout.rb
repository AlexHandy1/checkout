class Checkout
  attr_reader :scanned_items

  def initialize
    @scanned_items = []
  end

  def scan(item)
    @scanned_items << [item.code, item.name, item.price]
  end

  def total
    @scanned_items.map{|item|item.select.with_index{|_,i| i == 2}}.flatten.reduce(:+)
  end
end