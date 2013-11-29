require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../taxquestion'

describe Item do
  
  
  describe ".initialize" do
    
    context "when the item is tax-exempt and non-imported and taxable and imported parameters are not passed" do
      it "sets the item's name and price; taxable and imported default to false" do

        item = Item.new("foo", 10.0)
       
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(false)
        expect(item.imported).to eq(false)
      end
    end
    
    context "when the item is tax-exempt and non-imported and taxable and imported parameters are passed" do
      it "sets the item's name and price; taxable and imported are set to false" do
        
        item = Item.new("foo", 10.0, false, false)
        
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(false)
        expect(item.imported).to eq(false)
      end
    end

    context "when the item is tax-exempt and imported" do
      it "sets the item's name and price; taxable is set to false and imported to true" do 
        
        item = Item.new("foo", 10.0, false, true)
        
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(false)
        expect(item.imported).to eq(true)
      end
    end

    context "when the item is taxed and imported" do
      it "sets the item's name and price; taxable and imported are set to true" do

        item = Item.new("foo", 10.0, true, true)
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(true)
        expect(item.imported).to eq(true)
      end
    end
  end

  describe "#exempt_domestic?" do
    context "when item is tax-exempt and non-imported" do
      it "should return true" do 
        
        item = Item.new("foo", 10.0)
        expect(item.exempt_domestic?).to eq(true)
      end
    end
      context "when item is taxed and/or imported" do
      it "should return false" do 
        
        item = Item.new("foo", 10.0, true)
        expect(item.exempt_domestic?).to eq(false)
      end
    end
  end

  describe "#exempt_imported?" do
    context "when item is tax-exempt and imported" do
      it "should return true" do 
        
        item = Item.new("foo", 10.0, false, true)
        expect(item.exempt_imported?).to eq(true)
      end
    end
     context "when item is taxed and/or non-imported" do
      it "should return false" do 
        
        item = Item.new("foo", 10.0)
        expect(item.exempt_imported?).to eq(false)
      end
    end
  end


  describe "#taxable_domestic?" do
    context "when item is taxed and non-imported" do
      it "should return true" do 
        
        item = Item.new("foo", 10.0, true, false)
        expect(item.taxable_domestic?).to eq(true)
      end
    end
    context "when item is tax-exempt and/or imported" do
      it "should return false" do 
        
        item = Item.new("foo", 10.0)
        expect(item.taxable_domestic?).to eq(false)
      end
    end
  end

  describe "#taxable_imported?" do
    context "when item is taxed and imported" do
      it "should return true" do 
        
        item = Item.new("foo", 10.0, true, true)
        expect(item.taxable_imported?).to eq(true)
      end
    end
      context "when item is tax-exempt and/or non-imported" do
      it "should return false" do 
        
        item = Item.new("foo", 10.0)
        expect(item.taxable_imported?).to eq(false)
      end
    end
  end


  describe "#item_total_price" do 
    it "should return total item price including rounded tax" do

       item = Item.new("foo", 10.0, true, true)

       expect(item.item_total_price(15)).to eq(11.5)
    end
  end

  describe "#exempt_domestic" do
    it "should return the item price without added sales tax" do
      
      item = Item.new("foo", 10.0)

      expect(item.exempt_domestic).to eq(10.0)
    end
  end

  describe "#exempt_imported" do 
    it "should return the item price with 5% added sales tax" do
      
      item = Item.new("foo", 10.0, false, true)

      expect(item.exempt_imported).to eq(10.5)
    end
  end

  describe "#taxable_domestic" do 
    it "should return the item price with 10% added sales tax" do 
        
        item = Item.new("foo", 10.0, true)

        expect(item.taxable_domestic).to eq(11.0)
    end
  end

  describe "#taxable_imported" do 
    it "should return the item price with 15% added sales tax" do 

      item = Item.new("foo", 10.0, true, true)

      expect(item.taxable_imported).to eq(11.5)
    end
  end

end


