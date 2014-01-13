require_relative 'item'
require_relative 'shopping_cart'
require_relative 'register'
require_relative 'inventory_file'
require_relative 'government'
require_relative "item_calculator"

module SalesTax
  # Executes the application by passing in an input file.
  # Returns the receipt for a ShoppingCart instance.
  # 
  class CommandLine
    def initialize(files)
      if ARGV.length == 0
        puts "Usage: #{ARGV[0]} [files]"
        exit false
      end 

      ARGV.each do |path|
        shopping_cart = InventoryFile.new(path).read
    
        shopping_cart.purchase
      end
    end
  end
end