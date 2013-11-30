require_relative 'lib/item'
require_relative 'lib/shopping_cart'
require_relative 'lib/receipt'


# Creates instances of Item class.
# 
# Input 1:
# 
item1_1 = Item.new("book", 12.49)
item1_2 = Item.new("music CD", 14.99, true)
item1_3 = Item.new("chocolate bar", 0.85)

# Input 2: 
# 
item2_1 = Item.new("box of chocolates", 10.00, false, true)
item2_2 = Item.new("bottle of perfume", 47.50, true, true)

# Input 3: 
# 
item3_1 = Item.new("bottle of perfume", 27.99, true, true)
item3_2 = Item.new("bottle of perfume", 18.99, true, false)
item3_3 = Item.new("packet of headache pills", 9.75)
item3_4 = Item.new("box of chocolates", 11.25, false, true)

# Creates instances of ShoppingCart class.
# 
cart1 = ShoppingCart.new
cart2 = ShoppingCart.new
cart3 = ShoppingCart.new

# Adds items from Input 1 to cart1.
# 
cart1.add_item_to_cart(item1_1)
cart1.add_item_to_cart(item1_2)
cart1.add_item_to_cart(item1_3)

# Adds items from Input 2 to cart2.
# 
cart2.add_item_to_cart(item2_1)
cart2.add_item_to_cart(item2_2)

# Adds items from Input 3 to cart3.
# 
cart3.add_item_to_cart(item3_1)
cart3.add_item_to_cart(item3_2)
cart3.add_item_to_cart(item3_3)
cart3.add_item_to_cart(item3_4)

# Purchases each cart and prints out receipt.
# 
puts "Output 1:"
cart1.purchase
puts "\nOutput 2:"
cart2.purchase
puts "\nOutput 3:"
cart3.purchase