# Responsible for all receipt calculations. 
# Allows the printing of a receipt for a cart at any time pre- or post-purchase.
class Receipt 

  attr_accessor :sales_tax, :receipt_total, :cart
  
  def initialize(cart)
    @cart = cart.items
  end   
  
  def print
    if @cart.empty?
      "Shopping cart is empty. Add items before printing a receipt."
    else
     calculate_item_prices
     create_receipt
   end
  end

protected
  def calculate_item_prices
    @cart.each do |item|
      item.calculate_taxed_price   
    end
  end
  #Creates an empty array. 
  # Adds the rounded tax of each item to array.
  # Sum all elements of array to calcuate total sales tax for shopping cart.
  def calculate_total_sales_tax
    @sales_tax = []
    @cart.each do |item|
      @sales_tax << item.rounded_tax
    end    
    @sales_tax.inject(0,:+).round(2)    
  end

  # Creates an empty array.
  # Adds total price of each item to array.
  # Sums all elements of array to calculate total price for shopping cart.
  def calculate_receipt_total
    @receipt_total = []
    @cart.each do |item|
      @receipt_total << item.total_price
    end

    @receipt_total.inject(0,:+).round(2)
  end

  # Prints receipt information for each unique member of shopping cart items array
  def create_receipt
     @cart.uniq.each do |item|
      if item.imported
      puts "#{item.quantity} imported #{item.name}: #{item.total_price}"
      else
      puts "#{item.quantity} #{item.name}: #{item.total_price}" 
      end
    end
  
    puts "Sales Taxes: #{self.calculate_total_sales_tax}"
    puts "Total:#{self.calculate_receipt_total}"
  end
end