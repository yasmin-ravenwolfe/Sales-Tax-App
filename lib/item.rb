
class Item
  # Creates item and sets name, price, taxable, and imported attributes.
  # Taxable and imported default to false. 
  # 
  attr_accessor :name, :price, :taxable, :imported, :rounded_tax, :total_price, :quantity
    def initialize(name, price, taxable= false, imported= false)
      @name = name
      @price = price
      @taxable = taxable
      @imported = imported
      @quantity = 0
    end

    # Prints total price, including tax, for item.
    # 
    def view_taxed_price
      calculate_taxed_price
      self.total_price
    end

    # Calculate the total price of each item including tax based on tax type.
    # 
    def calculate_taxed_price

    # For tax-exempt, non-imported items.
    exempt_domestic if exempt_domestic?  
       
    # For tax-exempt, imported items.
    exempt_imported if exempt_imported?
      
      
    # For taxed, non-imported items.
    taxable_domestic if taxable_domestic?
      
   
    # For taxed, imported items.
    taxable_imported if taxable_imported?
            
    end
    
    protected
    # These methods determine the item's tax type. 
    # Tax type is set by the item's taxable and imported attributes.
    # 
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

    # These methods to calculate item price with rounded tax based on tax type.
    #
    # Tax-exempt, non-imported items are not taxed.
    # 
    def exempt_domestic 
      item_total_price(0)
    end
    
    # Tax-exempt, imported items are taxed 5%.
    # 
    def exempt_imported
      item_total_price(5)
    end
    
    # Taxed, non-imported items are taxed 10%.
    # 
    def taxable_domestic
     
      item_total_price(10)     
    end
    
    # Taxed, imported items are taxed 15%. 
    # 
    def taxable_imported
      item_total_price(15)
    end

    # Calculate tax rounded up to the nearest 0.05 and total price for each tax type.
    # 
    def item_total_price(n)
      raw_tax = (self.price * n)/ 100
      @rounded_tax = (raw_tax * 20).ceil / 20.0
      @total_price = (self.price + @rounded_tax).round(2)
    end
end










