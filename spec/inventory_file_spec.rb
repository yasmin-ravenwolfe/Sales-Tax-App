require 'rubygems'
require 'bundler/setup'
require 'rspec'

require_relative '../lib/inventory_file'

module SalesTax
  describe InventoryFile do 
    let(:inventory_file) {InventoryFile.new("spec/input1.txt")} 

    describe ".initialize" do 
      it "sets the path attribute" do

      

       expect(inventory_file.path).to eq("spec/input1.txt")
      end
    end

    describe "#read" do
      it "reads and parses the file and adds items to cart" do 

        inventory_file.read 

        expect(inventory_file.cart.items.size).to eq(3)
      end
    end


  end
end