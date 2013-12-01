require_relative 'government'
require_relative 'calculator'

module SalesTax
  # This class creates new items.
  # 
  class Item
   
    attr_accessor :rounded_tax, :total_price, :quantity
    attr_reader :name, :price, :taxable, :imported
    
    # Creates item and sets name and price attributes.
    # Creates a new Government instance to set taxable and imported attributes.
    # 
    def initialize(name, price)
      @name = name
      @price = price
      government = Government.new
      @taxable = government.taxable?(name)
      @imported = government.imported?(name)
      @quantity = 0
    end

    # Creates a new calculator instance to calculate total taxed price.
    # Returns total taxed price. 
    # 
    def view_taxed_price
      Calculator.new(self).calculate_taxed_price
      
      total_price
    end
    
    # These methods determine the item's tax type based on taxable and imported attributes. 
    # 
    # Returns true if an item is tax-exempt and non-imported.
    # 
    def exempt_domestic?  
      @taxable == false && @imported == false
    end
    
    # Returns true if an item is tax-exempt and imported.
    # 
    def exempt_imported?
      @taxable == false && @imported == true
    end
    
    # Returns true if an item is taxable and non-imported.
    # 
    def taxable_domestic?
      @taxable == true && @imported == false
    end
    
    # Returns true if an item is taxable and imported.
    # 
    def taxable_imported?
      @taxable == true && @imported == true
    end
  
    # Returns the name of the item as a string.
    def to_s
      "#{@name}"
    end    
  end
end










