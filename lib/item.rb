require_relative 'government'
require_relative 'item_calculator'

module SalesTax
  # This class creates new items.
  # 
  class Item
   
    attr_accessor  :quantity, :rounded_tax, :total_price
    attr_reader :name, :price, :taxable, :imported
    
    # Creates item and sets name and price attributes.
    # Creates a new Government instance to set taxable and imported attributes.
    # 
    def initialize(name, price)
      @name = name
      @price = price
      @quantity = 0
      @total_price = nil
      set_tax_status
    end

    def set_tax_status
      government = Government.new
      @taxable = government.taxable?(name)
      @imported = government.imported?(name)
    end
    # These methods determine the item's tax type based on taxable and imported attributes. 
    # 
    # Returns true if an item is tax-exempt and non-imported.
    # 
    def exempt_domestic?  
      taxable == false && imported == false
    end
    
    # Returns true if an item is tax-exempt and imported.
    # 
    def exempt_imported?
      taxable == false && imported == true
    end
    
    # Returns true if an item is taxable and non-imported.
    # 
    def taxable_domestic?
     taxable == true && imported == false
    end
    
    # Returns true if an item is taxable and imported.
    # 
    def taxable_imported?
      taxable == true && imported == true
    end
  
    
  end
end










