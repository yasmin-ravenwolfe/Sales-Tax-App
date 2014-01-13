require_relative 'item'
require_relative 'government'
require_relative 'shopping_cart'
require_relative 'calculator'
require 'bigdecimal'


module SalesTax  
  # Calculates receipt total and total sales tax. 
  # Prints a receipt for all items in cart.
  # 
  class Receipt 

    attr_reader :cart
    
    # Creates a new receipt.
    # Sets @cart equal to the items set of shopping cart passed in.
    # 
    def initialize(cart)
      @cart = cart.items
    end   
    
    # Calculates taxed item prices.
    # Returns a receipt for cart.
    def print
      if cart.empty?
        "Shopping cart is empty. Add items before printing a receipt."
      else
       calculate_item_prices
       create_receipt
     end
    end

  protected
    # Creates a new Calculator instance to calculate each item's taxed price.
    # 
    def calculate_item_prices
      cart.each do |item|
        Calculator.new(item).calculate_taxed_price  
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
    def create_receipt      
        cart.each do |item|
        if item.imported
         puts "#{item.quantity} imported #{item.name}: #{'%.2f' % item.total_price}"
        else
         puts "#{item.quantity} #{item.name}: #{'%.2f' % item.total_price}" 
        end
      end
    
       puts "Sales Taxes: #{'%.2f' % self.calculate_total_sales_tax}"
       puts "Total:#{'%.2f' % self.calculate_receipt_total}"
    end
  end
end