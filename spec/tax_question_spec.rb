require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../taxquestion'

describe Item do
  
  
  describe ".initialize" do
    
    context "when the item is tax-exempt and non-imported and taxable and imported parameters are not passed" do
      it "creates a new item and sets the item's name and price; taxable and imported default to false" do

        item = Item.new("foo", 10.0)
       
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(false)
        expect(item.imported).to eq(false)
      end
    end
    
    context "when the item is tax-exempt and non-imported and taxable and imported parameters are passed" do
      it "creates a new item and sets the item's name and price; taxable and imported are set to false" do
        
        item = Item.new("foo", 10.0, false, false)
        
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(false)
        expect(item.imported).to eq(false)
      end
    end

    context "when the item is tax-exempt and imported" do
      it "creates a new item and sets the item's name and price; taxable is set to false and imported to true" do 
        
        item = Item.new("foo", 10.0, false, true)
        
        expect(item.name).to eq("foo")
        expect(item.price).to eq(10.0)
        expect(item.taxable).to eq(false)
        expect(item.imported).to eq(true)
      end
    end

    context "when the item is taxed and imported" do
      it "creates a new item and sets the item's name and price; taxable and imported are set to true" do

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

describe ShoppingCart do
  let(:cart) {ShoppingCart.new}
  let(:item) {Item.new('foo',10)}
  describe ".initialize" do 
    it "creates a new shopping cart and sets items to an empty array" do 

      expect(cart.items).to eq([])
    end
  end

  describe "#add_item_to_cart" do 
    it "adds item to cart items array the specified number of times" do

      cart.add_item_to_cart(item, 2)

      expect(cart.items).to eq([item, item])
    end
  end

  describe "#remove_item_from_cart" do 
    context "when item is found in cart" do 
      it "removes item from cart items array" do 

        cart.remove_item_from_cart(item)

        expect(cart.items).to eq([])
      end
    end
    context "when item is not found in cart" do
      it "returns an error message" do 

        item2 = Item.new("bar",1.0)
        cart.remove_item_from_cart(item)

        expect(cart.remove_item_from_cart(item)).to eq("Item not found in cart.")
      end
    end
  end

  describe "#update_quantity_in_cart" do 
    context "when item is found in cart" do 
      it "updates the number of times an item is in the cart items array" do 

        cart.add_item_to_cart(item)
        cart.update_quantity_in_cart(item, 3)

        expect(cart.items).to eq([item, item, item])
      end
    end

    context "when item is not found in cart" do
      it "returns an error message" do

        

        expect(cart.update_quantity_in_cart(item, 3)).to eq("#{item.name.capitalize} not found in cart. Please add it before updating quantity.")
      end
    end
  end

  describe "#view_cart" do 
    context "when cart items array is empty" do
      it "returns an error message" do
        cart2 = ShoppingCart.new

        expect(cart2.view_cart).to eq("Your cart is empty. Please add some items.")
      end
    end
    context "when cart items array is not empty" do
      it "returns the unique items in cart" do 
        cart.add_item_to_cart(item, 2)

        expect(cart.view_cart).to eq([item])
      end
    end
  end
  
  describe "#calculate_item_prices" do
    it "returns total price with sales tax added of each item in cart" do 
    end
  end
end





