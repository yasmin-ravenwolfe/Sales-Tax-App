require_relative 'item'
require 'bigdecimal'
require "pry"

# Calculates the tax and total price for a single item.
# 
module SalesTax
  class ItemCalculator
  attr_reader :item
  
    def initialize(item)
      @item = item
    end
    
    # Calculates total taxed price based on tax type.
    # 
    def calculate_taxed_price
    # For tax-exempt, non-imported items.
    exempt_domestic if item.exempt_domestic?  
       
    # For tax-exempt, imported items.
    exempt_imported if item.exempt_imported?
      
      
    # For taxed, non-imported items.
    taxable_domestic if item.taxable_domestic?
      
   
    # For taxed, imported items.
    taxable_imported if item.taxable_imported?
            
    end

    protected
    
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
    
    # Taxable, non-imported items are taxed 10%.
    # 
    def taxable_domestic   
      item_total_price(10)     
    end
    
    # Taxable, imported items are taxed 15%. 
    # 
    def taxable_imported
      item_total_price(15)
    end

    # Calculates tax rounded up to the nearest 0.05.
    # Calculates total taxed price.
    # Use BigDecimal(versus floats) for precision because dealing with money.
    # 
    def item_total_price(n)
      raw_tax = BigDecimal.new("#{(@item.price * n)/ 100}")
      item.rounded_tax = BigDecimal.new("#{(raw_tax * 20).ceil / 20.0}")
      item.total_price = BigDecimal.new("#{(@item.price + @item.rounded_tax)}")
    end
  end
end