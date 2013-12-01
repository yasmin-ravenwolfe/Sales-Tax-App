require 'rubygems'
require 'bundler/setup'
require 'rspec'

require_relative '../lib/receipt'


module SalesTax
  describe Receipt do 
    let(:item) {Item.new("imported foo", 10.0)}
    let(:cart) {ShoppingCart.new}
    let(:receipt) {Receipt.new(cart)}

    before(:each) do
      cart.add_item_to_cart(item, 2)
      Receipt.send(:public, *Receipt.protected_instance_methods)  
    end

    describe ".initialize" do 
      it "creates a new receipt and sets cart to the items set of shopping cart passed in" do 

        expect(receipt.cart).to eq(cart.items)
      end
    end

    describe "#print" do
      it "calculates totals prices and returns the receipt for the shopping cart" do 

        receipt.print

        expect(item.total_price).to eq(11.5)
        expect(receipt.calculate_total_sales_tax).to eq(3.0)
        expect(receipt.calculate_receipt_total).to eq(23.0)
      end
    end



    describe "#calculate_item_prices" do
      it "returns total price with sales tax added of each item in shopping cart" do 
        receipt.calculate_item_prices
      
        expect(item.total_price).to eq(11.5)
      end
    end

    describe "#calculate_total_sales_tax" do 
      it "returns total sales tax of all items in shopping cart" do 
        
        receipt.calculate_item_prices
        
        expect(receipt.calculate_total_sales_tax).to eq(3.0)
      end
    end

    describe "#calculate_receipt_total" do
      it "returns total cost of all items in shopping cart including sales tax" do 

       receipt.calculate_item_prices
       
       expect(receipt.calculate_receipt_total).to eq(23.0) 
      end
    end

    describe '#create_receipt' do 
      it "returns a receipt with item price, total sales tax, and receipt total for all items in cart" do 

        receipt.calculate_item_prices
        receipt.create_receipt

        expect(item.total_price).to eq(11.5)
        expect(receipt.calculate_total_sales_tax).to eq(3.0)
        expect(receipt.calculate_receipt_total).to eq(23.0)
      end
    end
  end
end