
class Item
  # create item and pass in arguments- quanity and price
  # Optional args: taxable and import; defaults are false
  attr_accessor :name, :price, :taxable, :imported, :rounded_tax, :total_price, :quantity
    def initialize(name, price, taxable= false, imported= false)
      @name = name
      @price = price
      @taxable = taxable
      @imported = imported
      @quantity = 0
    end

    # Calculate the total price of each item including tax
    def calculate_taxed_price

    # For tax-exempt, non-imported items
      exempt_domestic if exempt_domestic?
       
       
      # For tax-exempt, imported items
      exempt_imported if exempt_imported?
        
        
      # For taxed, non-imported items
      taxable_domestic if taxable_domestic?
        
     
      # For taxed, imported items
      taxable_imported if taxable_imported?
            
    end
    
    # helper methods to determine each tax structure
    def exempt_domestic?  
      @taxable == false && @imported == false
    end
    def exempt_imported?
      @taxable == false && @imported == true
    end
    def taxable_domestic?
      @taxable == true && @imported == false
    end
    def taxable_imported?
      @taxable == true && @imported == true
    end

    # helper methods to calculate item price with rounded tax
    def exempt_domestic 
      item_total_price(0)
    end
    
    def exempt_imported
      item_total_price(5)
    end
    
    def taxable_domestic
     
      item_total_price(10)     
    end
    
    def taxable_imported
      item_total_price(15)
    end

    # Calculate tax and total price for each tax type
    def item_total_price(n)
      raw_tax = (self.price * n)/ 100
      @rounded_tax = (raw_tax * 20).ceil / 20.0
      @total_price = (self.price + @rounded_tax).round(2)
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
end

class Receipt 

  attr_accessor :sales_tax, :receipt_total
  
  def initialize
    # @cart = cart.items
  end   
  
  def purchase(cart)
     calculate_item_prices(cart)
     print_receipt(cart)
  end

  def calculate_item_prices(cart)
     cart.items.each do |item|
      item.calculate_taxed_price
    end
  end
  # Add the rounded tax of all items to an array
  # Sum that array to find total sales tax for each cart
  # Call after iterate through items array to calculate price so that all paramters are updated.
  def calculate_sales_tax(cart)
    @sales_tax = []
    cart.items.each do |item|
      @sales_tax << item.rounded_tax
    end    
    @sales_tax.inject(0,:+).round(2)     
  end

  def calculate_receipt_total(cart)
    @receipt_total = []
    cart.items.each do |item|
      @receipt_total << item.total_price
    end

    @receipt_total.inject(0,:+).round(2)
  end

  # Print info for unique members of array
  def print_receipt(cart)
     cart.items.uniq.each do |item|
      if item.imported == true
      puts "#{item.quantity} imported #{item.name}: #{item.total_price}"
      else
      puts "#{item.quantity} #{item.name}: #{item.total_price}" 
      end
    end
  
    puts "Sales Taxes: #{self.calculate_sales_tax(cart)}"
    puts "Total:#{self.calculate_receipt_total(cart)}"
  end


end




item1_1 = Item.new("book", 12.49)
item1_2 = Item.new("music CD", 14.99, true)
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


