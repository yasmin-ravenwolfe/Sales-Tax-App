class Item
  # create item and pass in arguments- quanity and price
  # Optional args: taxable and import; defaults are false
  attr_accessor :price, :taxable, :imported
    def initialize(price, taxable= false, imported= false)
      # @quantity = quantity
      @price = price
      @taxable = taxable
      @imported = imported
    end
  # book1 = Item.new(12.49)
  # impchoc = Item.new(10.00, false, true)
  # impperfume = Item.new(47.50, true, true)

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
  def receipt

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

  # method for rounding
  
  def find_cart_quantity(item)
    @items.count(item)
  end

  def item_quantity
    # for receipt will need to only print each unique item once, but multipled by its total_price
    total_items_price = item.price * self.find_cart_quantity(item)
  end
  # methods for each tax structure
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

  def exempt_domestic(item)
    total_tax = 0.0
    total_price = item.price
    puts "#{item} costs #{total_price}"
  end
  def exempt_imported(item)
    total_tax = item.price * 0.05
    total_price = item.price + total_tax
    puts "#{item} costs #{total_price}"
  end
  def taxable_domestic(item)
    total_tax = item.price * 0.10
    total_price = item.price + total_tax
    puts "#{item} costs #{total_price}"
  end
  def taxable_imported(item)
    total_tax = item.price * 0.15
    total_price = item.price + total_tax
    puts "#{item} costs #{total_price}"
  end
  # all are called in a receipt method 
end

class Calculator
  # calculate tax

end



class Receipt
  # print receipt 
  def purchase
    #return receipt
  end
end

item1 = Item.new(10.0)
item2 = Item.new(20.0, false, true)
item3 = Item.new(100.0, true, false)
item4 = Item.new(500.0, true, true)
cart1 = ShoppingCart.new
cart1.add_item_to_cart(item1, 2)
cart1.add_item_to_cart(item2)
cart1.add_item_to_cart(item3)
cart1.add_item_to_cart(item4)


