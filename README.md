Summary
=================

* My implementation of a checkout system with flexible discounts built in Ruby - developed using TDD methodology with feature and unit tests.

* Based on the specification, I made a number of key implementation decisions:

  * Modelled domain with independent Checkout and Item objects to allow for list of items to be easily extended

  * Enabled flexible promotional rules through encapsulating the logic for discounts in Proc's that could be stored in a hash constant ```PROMOTIONAL_RULES``` and instantiated with the Checkout object ```Checkout.new(PROMOTIONAL_RULES)```
  * The area that I would be keen to develop further is how to further enhance flexibility of discounts - current version encapsulates the discount logic as an interchangeable validation check based on inputting total cost of items and full array of scanned items. To extend I would continue to explore how to encapsulate entire logic and return variable output as closure (e.g. item_total) in Proc or similar design pattern.

Use Cases:
-------

```
    - [x] As a cashier,
          So that I can process an order,
          I want to be able to calculate the total price of scanned basket items

    - [x] As a cashier
         So that I can offer discounts
         I want to be able to apply a flexible range of discount offers to relevant scanned basket items
```

How to run
----

### Local Installation

Run the below commands in your command line interface to view the static web page and run the test suite. Ensure have Ruby and Rspec installed on your local machine.

```
git clone https://github.com/AlexHandy1/checkout
cd checkout
rspec

irb
require './lib/checkout.rb'
#load up the promotions logic and instantiate checkout
  PROMO1 = Proc.new do |scanned_items, item_total|
    scanned_items.map{|x| x[1]}.select{|x| x == "Lavender heart"}.length > 1
  end

  PROMO2 = Proc.new do |item_total|
    item_total > 60
  end

  PROMOTIONAL_RULES = {"promo1":  PROMO1, "promo2": PROMO2}

  co = Checkout.new(PROMOTIONAL_RULES)

#instantiate the items you want to checkout
  item1 = Item.new "001", "Lavender heart", 9.25
  item2 = Item.new "002", "Personalised cufflinks", 45.00
  item3 = Item.new "003", "Kids T-Shirt", 19.95

#run commands
  co.scan(item1)
  co.scan(item2)
  co.scan(item3)
  price = co.total

```

Technologies used
----

* Production - Ruby
* Testing - Rspec, Capybara