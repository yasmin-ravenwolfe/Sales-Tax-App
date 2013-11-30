
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

    def view_taxed_price
      calculate_taxed_price
      self.total_price
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
    
    protected
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










