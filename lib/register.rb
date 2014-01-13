require_relative 'item'
require_relative 'government'
require_relative 'shopping_cart'
require_relative 'item_calculator'
require 'bigdecimal'

# Acts like a register at a store.
# Initiates total calculations and prints receipt.
# Delegates the calculation of an individual item to the Calculator class but is responsible for calculations that occur upon checkout.
#
module SalesTax  
  # Calculates receipt total and total sales tax. 
  # Prints a receipt for all items in cart.
  # 
  class Register 

    attr_reader :cart
    
    # Creates a new receipt.
    # Sets @cart equal to the items set of shopping cart passed in.
    # 
    def initialize(cart)
      @cart = cart.items
    end   
    
    # Calculates taxed item prices.
    # Returns a receipt for cart.
    def checkout
      if cart.empty?
        "Shopping cart is empty. Add items before printing a receipt."
      else
       calculate_item_prices
       print_receipt
     end
    end

  protected
    # Creates a new Calculator instance to calculate each item's taxed price.
    # 
    def calculate_item_prices
      cart.each do |item|
        ItemCalculator.new(item).calculate_taxed_price  
      end
    end
    
    # Calculates total sales tax for all items in shopping cart.
    # 
    def calculate_total_sales_tax
      sales_tax = []
      
      cart.each do |item|
        sales_tax << BigDecimal.new("#{item.rounded_tax * item.quantity}")
      end    
      
      sales_tax.reduce(0,:+)    
    end


    # Calculates grand total, including tax, of all items in shopping cart. 
    # 
    def calculate_receipt_total
      receipt_total = []
      
      cart.each do |item|
        receipt_total << BigDecimal.new("#{item.total_price * item.quantity}")
      end
     
      receipt_total.reduce(0,:+)
    end

    # Prints receipt for shopping cart. 
    # Prints quantity, name, and total taxed price for each item.
    # Prints total sales tax of all items in shopping cart.
    # Prints total taxed price of all items in shopping cart.
    # 
    def print_receipt      
      cart.each do |item|
     
       puts "#{item.quantity} #{item.name}: #{'%.2f' % item.total_price}" 
      
      end
  
     puts "Sales Taxes: #{'%.2f' % self.calculate_total_sales_tax}"
     puts "Total:#{'%.2f' % self.calculate_receipt_total}"
    end
  end
end