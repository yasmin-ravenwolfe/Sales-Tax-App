require_relative 'shopping_cart'
require_relative 'item'
require 'bigdecimal'


module SalesTax
  # Reads a file.
  # Parses each line to create a new Item instance.
  # Adds items to a ShoppingCart instance.
  # 
  class InventoryFile
    attr_reader :path, :cart

    def initialize(path)
      @path = path
    end

    # Reads the passed in file.
    # Parses each line of file to create a new Item instance.
    # Adds Item instance to ShoppingCart instance.
    # Returns ShoppingCart instance.
    # 
    def read
      cart = ShoppingCart.new
      File.open(@path, 'r') do |file|
        file.each_line do |line|
          item, quantity = parse(line)
          cart.add_item_to_cart(item,quantity)
        end
      end

    cart
    end

    # Parses each line to set Item instance quantity, name, and price attributes.
    # Returns an array of the Item instance and its quantity.
    # 
    def parse(line)
      line_matcher = /^(\d+) (.+) at (\d+\.\d{2})$/ 
    
      raise "Invalid line: #{line}" unless line_matcher =~ line
      matches = line_matcher.match(line)
      quantity = matches[1].to_i
      name = matches[2]
      price = BigDecimal.new("#{matches[3]}")
      item = Item.new(name, price)

      [item, quantity]
    end 
  end
end

