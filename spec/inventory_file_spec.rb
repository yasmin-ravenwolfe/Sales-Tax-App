require 'rubygems'
require 'bundler/setup'
require 'rspec'

require_relative '../lib/inventory_file'

module SalesTax
  describe InventoryFile do 
    let(:inventory_file) {InventoryFile.new('path')} 

    describe ".initialize" do 
      it "sets the path attribute" do

       expect(inventory_file.path).to eq('path')
      end
    end

    describe "#write" do 
      it "should write to file" do
        
        items = [Item.new("1 box of foo", 10.00)]
        file = double('file') 
        result = inventory_file.write(items)

        expect(result).to eq(items)
      end
    end

    describe "#read" do
      it "reads and parses the file and adds items to cart" do 
        
        file = double('file') 
        line = '1 box of imported chocolates at 10.00'
        File.should_receive(:open).with('path', "r").and_yield(file)
        file.should_receive(:each_line).and_yield(line)
        result = inventory_file.read 

        expect(result.items.size).to eq(1)
      end
    end

    describe "#serialize" do 
      it "returns the item quanity, name, and price" do 
      
        item = Item.new("box of chocolates", 10.00)
        item.quantity = 1
        result = inventory_file.serialize(item)
        expect(result).to eq("1 box of chocolates at 10.00")
      end
    end

    describe "#parse" do 
      it "creates a new item returns an array of the item and quantity" do 
        
        result = inventory_file.parse("1 imported box of chocolates at 10.00")
    
        expect(result[0].name).to eq("imported box of chocolates")
        expect(result[0].price).to eq(10.00)
        expect(result[1]).to eq(1)
      end     
    end
  end
end