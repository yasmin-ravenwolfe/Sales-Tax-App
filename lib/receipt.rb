require_relative 'item'
require_relative 'government'
require_relative 'shopping_cart'
require_relative 'calculator'


module SalesTax  
  # Responsible for all receipt calculations. 
  # Allows the printing of a receipt for a cart at any time pre- or post-purchase.
  class Receipt 

    attr_accessor :sales_tax, :receipt_total, :cart
    
    # Creates a new receipt.
    # Sets @cart equal to the @items array of shopping cart passed in.
    # 
    def initialize(cart)
      @cart = cart.items
    end   
    
    # Prints out a receipt for items in cart without purchasing cart.
    # 
    def print
      if @cart.empty?
        "Shopping cart is empty. Add items before printing a receipt."
      else
       calculate_item_prices
       create_receipt
     end
    end

  protected
    # For each item in cart, calculates the taxed price based on tax type.
    # 
    def calculate_item_prices
      @cart.each do |item|
        Calculator.new(item).calculate_taxed_price  
      end
    end
    
    # Calculates total sales tax for all the cart's items.
    # Adds the rounded tax of each item to an empty array.
    # Sums this array.
    # 
    def calculate_total_sales_tax
      @sales_tax = []
      
      @cart.each do |item|
        @sales_tax << item.rounded_tax * item.quantity
      end    
      
      @sales_tax.reduce(0,:+).round(2)    
    end


    # Calculates grand total for all the cart's items, including tax.
    # Adds the total price of each item to an empty array.
    # Sums this array.
    # 
    def calculate_receipt_total
      @receipt_total = []
      
      @cart.each do |item|
        @receipt_total << item.total_price * item.quantity
      end
     
      @receipt_total.reduce(0,:+).round(2)
    end

    # Prints receipt information for each unique member of shopping cart.
    # 
    def create_receipt
       @cart.each do |item|
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