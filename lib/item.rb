require_relative 'government'
module SalesTax
  # This class creates new items and sets attributes to determine tax rate.
  # 
  class Item
   
    attr_accessor :name, :price, :taxable, :imported, :rounded_tax, :total_price, :quantity
    
    # Creates item and sets name, price, taxable, and imported attributes.
    # Taxable and imported default to false. 
    # 
    def initialize(name, price)
      @name = name
      @price = price
      government = Government.new
      @taxable = government.taxable?(name)
      @imported = government.imported?(name)
      @quantity = 0
    end

    # Prints total price, including tax, for item.
    # 
    def view_taxed_price
      calculate_taxed_price
      self.total_price
    end
    

    def to_s
      "#{@name}"
    end
    
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
  end
end










