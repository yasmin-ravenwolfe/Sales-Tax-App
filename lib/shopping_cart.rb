require_relative 'item'
require_relative 'receipt'

module SalesTax
  class ShoppingCart
  require 'set'
    attr_accessor :items
    attr_reader :receipt
    
    # Creates a new shopping cart.
    # Sets @items to an empty array. 
    # 
    def initialize
      @items = Set.new  
    end
    
    # Adds items to a particular cart by pushing into the @items array
    # By default, adds one items
    # If quanity is set, will add that number of items to cart and increment quantity
    # 
    def add_item_to_cart(item, quantity=1)
      quantity.times do |x|
      @items.add(item)
      item.quantity += 1
      end
    end

    # Removes item from @items array
    # 
    def remove_item_from_cart(item)
      if @items.include?(item)
        @items.delete(item)
        item.quantity = 0
      "#{item.name.capitalize} removed from cart."
      else
        "Item not found in shopping cart."
      end
    end

    # Changes the quantity of an item in the @items array. 
    # Removes item from @items array in order to avoid duplicates.
    # 
    def update_quantity_in_cart(item, new_quantity)
      if @items.include?(item)
          item.quantity = new_quantity
          "#{item.name.capitalize} quantity has been updated to #{item.quantity}."
      else
        "#{item.name.capitalize} not found in shopping cart. Please add it before updating quantity."
      end
    end

    # Prints a list of each item, quantity, item price, and total price for each item in cart.
    # 
    def view_cart
      if @items.empty?
        "Your shopping cart is empty. Please add some items."
      else
        @items.each do |item|
          puts "#{item.name.capitalize}: #{item.quantity} in shopping cart at #{item.price} each for a total price of #{item.quantity * item.price}. This does not include sales tax."
        end
      end
    end

    # Simulates purchasing a cart and prints out a receipt.
    # 
    def purchase
      if @items.empty?
         "Shopping cart is empty. There is nothing to purchase"
      else
        @receipt = Receipt.new(self).print 
      end  
    end
  end
end