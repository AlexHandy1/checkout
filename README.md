```
    - [x] As a cashier,
          So that I can process an order,
          I want to be able calculate the total price of scanned basket items

    - [x] As a cashier
         So that I can offer discounts
         I want to apply two discount offers to relevant scanned basket items
```

Domain Modelling

Checkout object
>> responsible for scanning items and calculating total cost with discounts applied
>> actions scan and total

Item object
>> responsible for knowing its code, name and price
>> e.g. co.scan(Item.new(001, Lavender Heart, £9.25))

Promotional rules object
>> responsible for storing the rules that apply to checkout
Checkout.new(Promotions.new)
Promotions.current_promotions >> iterate through an array of methods?