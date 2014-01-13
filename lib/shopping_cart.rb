require_relative 'item'
require_relative 'register'

module SalesTax
  class ShoppingCart
  require 'set'
    attr_accessor :items, :receipt
    # attr_reader :receipt
    
    # Creates a new shopping cart.
    # Sets @items to an empty set. 
    # 
    def initialize
      @items = Set.new  
    end
    
    # Adds item to shopping cart.
    # Increments item quantity in shopping cart.
    # 
    def add_item_to_cart(item, quantity=1)
      quantity.times do |x|
      @items.add(item)
      item.quantity += 1
      end
    end


    # Simulates purchasing a cart. 
    # Creates a new Register instance to calculate totals and print a receipt.
    # 
    def purchase
      if @items.empty?
         "Shopping cart is empty. There is nothing to purchase"
      else
        Register.new(self).checkout 
      end  
    end
  end
end