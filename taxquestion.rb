class Item
  # create item and pass in arguments- quanity and price
  # Optional args: taxable and import; defaults are false
  attr_reader :name, :price, :taxable, :imported
    def initialize(name, price, taxable= false, imported= false)
      @name = name
      @price = price
      @taxable = taxable
      @imported = imported
    end


end

class ShoppingCart
  #create a shopping cart that is an empty array
  # cart1 = ShoppingCart.new
  attr_accessor :items
  def initialize
    @items = []
  end
  #Add items to a particular cart by pushing into the array
  # cart1.add_item_to_cart(item1,2)
  # So that cart1.items => [item1, item1]
  def add_item_to_cart(item, quantity=1)
    # Push item into cart array a specified number of times
    quantity.times do |x|
    @items << item
    end
  end

  # Calculate the total price of each item including tax
  def calculator

    self.items.each do |item|
    # For tax-exempt, non-imported items
      if exempt_domestic?(item)
       exempt_domestic(item)
       
      # For tax-exempt, imported items
      elsif exempt_imported?(item)
        exempt_imported(item)
        
      # For taxed, non-imported items
      elsif taxable_domestic?(item)
        taxable_domestic(item)
     
      # For taxed, imported items
      elsif taxable_imported?(item) 
        taxable_imported(item)
      end    
    end
  end



  # helper methods to determine each tax structure
  def exempt_domestic?(item)
    item.taxable == false && item.imported == false
  end
  def exempt_imported?(item)
    item.taxable == false && item.imported == true
  end
  def taxable_domestic?(item)
    item.taxable == true && item.imported == false
  end
  def taxable_imported?(item)
    item.taxable == true && item.imported == true
  end

  # helper methods to calculate item price with rounded tax
  def exempt_domestic(item)
    rounded_tax = 0.0
    total_price = item.price
    puts "#{item.name} costs #{total_price}"
  end
  def exempt_imported(item)
    raw_tax = (item.price * 5) / 100
    rounded_tax = (raw_tax * 20).ceil / 20.0
    total_price = item.price + rounded_tax
    puts "#{item.name} costs #{total_price}"
  end
  def taxable_domestic(item)
    raw_tax = (item.price * 10) / 100
    rounded_tax = (raw_tax * 20).ceil / 20.0
    # Because floats use binary numbers, some numbers like 10, will give a random decimal. So, round to 2 decimal places to get correct total price. 
    # Can use BigDecimal library to avoid; but not in this exercise because it is an external library.
    total_price = (item.price + rounded_tax).round(2)
    puts "#{item.name} costs #{total_price}"
    
  end
  def taxable_imported(item)
    raw_tax = (item.price * 15)/100
    rounded_tax = (raw_tax * 20).ceil / 20.0
    total_price = item.price + rounded_tax  
    puts "#{item.name} costs #{total_price}"
  end
  # all are called in a receipt method   
end



class Receipt
  # print receipt 
  def initialize
  end

  def receipt(cart)
    
  end
  def item_quantity
    # for receipt will need to only print each unique item once, but multipled by its total_price
    total_items_price = item.price * self.find_cart_quantity(item)
  end
  # def find_cart_quantity(item)
  #   @items.count(item)
  # end
  # def find_cart_quantity(cart,item)
  #   cart.items.count(item)
  # end
end

item1_1 = Item.new("book", 12.49)
item1_2 = Item.new("music CD", 14.99, true, false)
item1_3 = Item.new("chocolate bar", 0.85)
item2_1 = Item.new("box of chocolates", 10.00, false, true)
item2_2 = Item.new("bottle of perfume",47.50, true, true)
item3_1 = Item.new("bottle of perfume",27.99, true, true)
item3_2 = Item.new("bottle of perfume", 18.99, true, false)
item3_3 = Item.new("packet of headache pills", 9.75)
item3_4 = Item.new("box of chocolates", 11.25, false, true)

cart1 = ShoppingCart.new
cart2 = ShoppingCart.new
cart3 = ShoppingCart.new

cart1.add_item_to_cart(item1_1)
cart1.add_item_to_cart(item1_2)
cart1.add_item_to_cart(item1_3)

cart2.add_item_to_cart(item2_1)
cart2.add_item_to_cart(item2_2)

cart3.add_item_to_cart(item3_1)
cart3.add_item_to_cart(item3_2)
cart3.add_item_to_cart(item3_3)
cart3.add_item_to_cart(item3_4)

