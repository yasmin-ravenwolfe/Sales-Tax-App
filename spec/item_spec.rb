require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../lib/item'


module SalesTax
  describe Item do
    let(:exempt_domestic_item) {Item.new("chocolate", 10.0)}
    let(:exempt_imported_item) {Item.new("imported chocolate", 10.0)}
    let(:taxed_domestic_item) {Item.new("foo", 10.0)}
    let(:taxed_imported_item) {Item.new("imported foo", 10.0)}

    before(:each) do
      Item.send(:public, *Item.protected_instance_methods)   
    end
    
    describe ".initialize" do
      
      context "when the item is tax-exempt and non-imported" do
        it "creates a new item and sets the item's name and price; taxable and imported are set to false" do

          
         
          expect(exempt_domestic_item.name).to eq("chocolate")
          expect(exempt_domestic_item.price).to eq(10.0)
          expect(exempt_domestic_item.taxable).to eq(false)
          expect(exempt_domestic_item.imported).to eq(false)
        end
      end
      
      context "when the item is tax-exempt and imported" do
        it "creates a new item and sets the item's name and price; taxable is set to false and imported to true" do 
         
          
          expect(exempt_imported_item.name).to eq("imported chocolate")
          expect(exempt_imported_item.price).to eq(10.0)
          expect(exempt_imported_item.taxable).to eq(false)
          expect(exempt_imported_item.imported).to eq(true)
        end
      end

        context "when the item is taxed and non-imported" do
          it "creates a new item and sets the item's name and price; taxable is set to true and imported is set to false" do

           
            expect(taxed_domestic_item.name).to eq("foo")
            expect(taxed_domestic_item.price).to eq(10.0)
            expect(taxed_domestic_item.taxable).to eq(true)
            expect(taxed_domestic_item.imported).to eq(false)
          end
        end
      

      context "when the item is taxed and imported" do
        it "creates a new item and sets the item's name and price; taxable and imported are set to true" do

        
          expect(taxed_imported_item.name).to eq("imported foo")
          expect(taxed_imported_item.price).to eq(10.0)
          expect(taxed_imported_item.taxable).to eq(true)
          expect(taxed_imported_item.imported).to eq(true)
        end
      end
    end

    describe "#exempt_domestic?" do
      context "when item is tax-exempt and non-imported" do
        it "should return true" do 
          
         
          expect(exempt_domestic_item.exempt_domestic?).to eq(true)
        end
      end
        context "when item is taxed and/or imported" do
        it "should return false" do 
          
          expect(taxed_domestic_item.exempt_domestic?).to eq(false)
        end
      end
    end

    describe "#exempt_imported?" do
      context "when item is tax-exempt and imported" do
        it "should return true" do 
       
          expect(exempt_imported_item.exempt_imported?).to eq(true)
        end
      end
       context "when item is taxed and/or non-imported" do
        it "should return false" do 
          
          expect(taxed_domestic_item.exempt_imported?).to eq(false)
        end
      end
    end


    describe "#taxable_domestic?" do
      context "when item is taxed and non-imported" do
        it "should return true" do 
          
          expect(taxed_domestic_item.taxable_domestic?).to eq(true)
        end
      end
      context "when item is tax-exempt and/or imported" do
        it "should return false" do 
          
          expect(exempt_domestic_item.taxable_domestic?).to eq(false)
        end
      end
    end

    describe "#taxable_imported?" do
      context "when item is taxed and imported" do
        it "should return true" do 
          
        
          expect(taxed_imported_item.taxable_imported?).to eq(true)
        end
      end
        context "when item is tax-exempt and/or non-imported" do
        it "should return false" do 
        
          expect(exempt_imported_item.taxable_imported?).to eq(false)
        end
      end
    end

    describe "view_taxed_price" do
      it "returns the total price with tax added" do 

        expect(taxed_imported_item.view_taxed_price).to eq(11.5)
      end
    end
  end
end

