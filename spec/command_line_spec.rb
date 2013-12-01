require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../lib/command_line'


module SalesTax
  describe CommandLine do 
    describe ".initialize" do 
      it "returns a receipt for file passed in as argument" do 

        ARGV = double('ARGV')
        files = double('files')
        path = double('path')
        ARGV.should_receive(:length).and_return(1)
        ARGV.should_receive(:each).and_yield(path)
        # line = '1 box of chocolates at 10.00'
        item = Item.new("box of foo", 10.00)
        shopping_cart = ShoppingCart.new
        shopping_cart.add_item_to_cart(item)
        result = CommandLine.new(files)

       expect(result).to eq(shopping_cart.purchase)
      end
    end



  end
end