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
    item.quantity += 1
    end
  end

  def remove_item_from_cart(item)
    if @items.include?(item)
      @items.delete(item)
    "#{item.name.capitalize} removed from cart."
    else
      "Item not found in cart."
    end
  end

  def update_quantity_in_cart(item, new_quantity)
    if @items.include?(item)
        self.remove_item_from_cart(item)
        self.add_item_to_cart(item, new_quantity)
        item.quantity = new_quantity
        "#{item.name.capitalize} quantity has been updated to #{item.quantity}."
      else
        "#{item.name.capitalize} not found in cart. Please add it before updating quantity."
    end
  end

  def view_cart
    if self.items.empty?
      "Your cart is empty. Please add some items."
    else
      self.items.uniq.each do |item|
        puts "#{item.name.capitalize}: #{item.quantity} in cart at #{item.price} each for a total price of #{item.quantity * item.price}. This does not include sales tax."

      end
    end
  end

  # Simulates purchasing a cart by printing out a receipt
  def purchase
    if self.items.empty?
       "Shopping cart is empty. There is nothing to purchase"
    else
      puts "Receipt:"
      Receipt.new(self).print 
    end  
  end
end