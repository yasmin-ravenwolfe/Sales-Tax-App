module SalesTax
  class Calculator

    def initialize(item)
      @item = item
    end
    # Calculate the total price of each item including tax based on tax type.
    # After calling this method, total price attribute is set on item.
    # 
    def calculate_taxed_price(item)

    # For tax-exempt, non-imported items.
    exempt_domestic(item) if item.exempt_domestic?  
       
    # For tax-exempt, imported items.
    exempt_imported(item) if item.exempt_imported?
      
      
    # For taxed, non-imported items.
    taxable_domestic(item) if item.taxable_domestic?
      
   
    # For taxed, imported items.
    taxable_imported(item) if item.taxable_imported?
            
    end
    # protected
    # These methods determine the item's tax type. 
    # Tax type is set by the item's taxable and imported attributes.
    # 


    # These methods to calculate item price with rounded tax based on tax type.
    #
    # Tax-exempt, non-imported items are not taxed.
    # 
    def exempt_domestic(item)
      item_total_price(item,0)
    end
    
    # Tax-exempt, imported items are taxed 5%.
    # 
    def exempt_imported(item)
      item_total_price(item,5)
    end
    
    # Taxed, non-imported items are taxed 10%.
    # 
    def taxable_domestic(item)
     
      item_total_price(item,10)     
    end
    
    # Taxed, imported items are taxed 15%. 
    # 
    def taxable_imported(item)
      item_total_price(item,15)
    end

    # Calculate tax rounded up to the nearest 0.05 and total price for each tax type.
    # 
    def item_total_price(item, n)
      raw_tax = (item.price * n)/ 100
      item.rounded_tax = (raw_tax * 20).ceil / 20.0
      item.total_price = (item.price + item.rounded_tax).round(2)
    end
  end
end