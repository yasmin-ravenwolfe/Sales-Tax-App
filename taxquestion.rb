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

  def calculate

    @items.each do |item|
    # For tax-exempt, non-imported items
      if item.taxable == false && item.imported == false
        total_tax = 0.0
        total_price = item.price
        print item_price
      end
    end
  end

  # method for rounding
  
  def find_cart_quantity(item)
    @items.count(item)
  end

  def total
    total_items_price = item.price * self.find_cart_quantity(item)
  end
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
cart1 = ShoppingCart.new
cart1.add_item_to_cart(item1, 2)
item2 = Item.new(20.0)
cart1.add_item_to_cart(item2)

