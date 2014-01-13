require_relative 'item'
require_relative 'item_calculator'
require 'bigdecimal'

module SalesTax
  class ExemptImportedCalculator
    
    attr_reader :item
    
    def initialize(item)
      @item = item
      item_total_price
    end

    def item_total_price
      raw_tax = BigDecimal.new("#{(@item.price * 5)/ 100}")
      item.rounded_tax = BigDecimal.new("#{(raw_tax * 20).ceil / 20.0}")
      item.total_price = BigDecimal.new("#{(@item.price + @item.rounded_tax)}")
    end
  
  end
end