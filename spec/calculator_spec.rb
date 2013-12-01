require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../lib/calculator'


module SalesTax
  describe Calculator do 
  let(:item) {Item.new("foo", 10.00)}
  let(:exempt_domestic_item) {Item.new("chocolate", 10.0)}
  let(:exempt_imported_item) {Item.new("imported chocolate", 10.0)}
  let(:taxed_domestic_item) {Item.new("foo", 10.0)}
  let(:taxed_imported_item) {Item.new("imported foo", 10.0)}
  let(:calculator) {Calculator.new(item)}

  before(:each) do
    Calculator.send(:public, *Calculator.protected_instance_methods)   
  end
    
    describe ".initialize" do 
      it "creates a new calculator" do 

        expect(calculator.item.name).to eq("foo")
      end
    end

    describe "#calculate_taxed_price" do 
      it "returns an item's rounded tax and total price based on tax type" do 

        calculator.calculate_taxed_price
        
        expect(item.rounded_tax).to eq(1.00)
        expect(item.total_price).to eq(11.00)
      end
    end

    describe "#exempt_domestic" do
      it "returns the item price without added sales tax" do
        
        calc = Calculator.new(exempt_domestic_item)

        expect(calc.exempt_domestic).to eq(10.0)
      end
    end

    describe "#exempt_imported" do 
      it "returns the item price with 5% added sales tax" do

        calc = Calculator.new(exempt_imported_item)

        expect(calc.exempt_imported).to eq(10.5)
      end
    end

    describe "#taxable_domestic" do 
      it "returns the item price with 10% added sales tax" do 

        calc = Calculator.new(taxed_domestic_item)

        expect(calc.taxable_domestic).to eq(11.0)
      end
    end

    describe "#taxable_imported" do 
      it "returns the item price with 15% added sales tax" do 

        calc = Calculator.new(taxed_imported_item)

        expect(calc.taxable_imported).to eq(11.5)
      end
    end

    describe "#item_total_price" do 
      it "returns the items' rounded tax and total price based on tax rate" do

      calculator.item_total_price(10)
      
      expect(item.rounded_tax).to eq(1.00)
      expect(item.total_price).to eq(11.00)
      end
    end
  end
end
