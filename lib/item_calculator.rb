require_relative 'item'
require_relative 'exempt_domestic_calculator'
require_relative 'exempt_imported_calculator'
require_relative 'taxable_domestic_calculator'
require_relative 'taxable_imported_calculator'

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
    ExemptDomesticCalculator.new(item) if item.exempt_domestic?  
       
    # For tax-exempt, imported items.
    ExemptImportedCalculator.new(item) if item.exempt_imported?
      
      
    # For taxed, non-imported items.
    TaxableDomesticCalculator.new(item) if item.taxable_domestic?
      
   
    # For taxed, imported items.
    TaxableImportedCalculator.new(item) if item.taxable_imported?
            
    end

    protected
    


    # Calculates tax rounded up to the nearest 0.05.
    # Calculates total taxed price.
    # Use BigDecimal(versus floats) for precision because dealing with money.
    # # 
    # def item_total_price

    # end
  end
end