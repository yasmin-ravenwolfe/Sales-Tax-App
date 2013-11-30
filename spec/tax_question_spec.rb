require 'rubygems'
require 'bundler/setup'
require 'rspec'
# require_relative '../tax_question'
require_relative '../lib/item'
require_relative '../lib/shopping_cart'
require_relative '../lib/receipt'

describe Item do
  
  before(:each) do
    Item.send(:public, *Item.protected_instance_methods)   
  end
  
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

  describe "#calculate_taxed_price" do
    it "returns the item price with sales tax" do

      item = Item.new("foo", 10.0, true, true)
      item.calculate_taxed_price

      expect(item.total_price).to eq(11.5)
    end
  end

  describe "view_taxed_price" do
    it "returns the total price with tax added" do 

      item = Item.new("foo", 10.0, true, true)
      expect(item.view_taxed_price).to eq(11.5)
    end
  end
end

describe ShoppingCart do
  let(:cart) {ShoppingCart.new}
  let(:item) {Item.new('foo',10)}
  describe ".initialize" do 
    it "creates a new shopping cart and sets items to an empty array" do 

      expect(cart.items.size).to eq(0)
    end
  end

  describe "#add_item_to_cart" do 
    it "adds item to cart items array the specified number of times" do

      cart.add_item_to_cart(item, 2)

      expect(item.quantity).to eq(2)
    end
  end

  describe "#remove_item_from_cart" do 
    context "when item is found in cart" do 
      it "removes item from cart items array" do 

        cart.remove_item_from_cart(item)

        expect(cart.items.size).to eq(0)
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

        expect(cart.items.size).to eq(1)
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

        expect(cart.view_cart.to_a).to eq([item])
      end
    end
  end

  describe "#purchase" do 
    context "when shopping cart is empty" do
      it "returns error message" do 

        expect(cart.purchase).to eq("Shopping cart is empty. There is nothing to purchase")
      end
    end
    context "when shopping cart items array is not empty" do
      it "returns a receipt for the shopping cart" do

        cart.add_item_to_cart(item, 2)

        expect(cart.purchase).to eq(Receipt.new(cart).print)
      end
    end
  end
end

describe Receipt do 
  let(:item) {Item.new("foo", 10.0, true, true)}
  let(:cart) {ShoppingCart.new}
  let(:receipt) {Receipt.new(cart)}

  before(:each) do
    cart.add_item_to_cart(item, 2)
    Receipt.send(:public, *Receipt.protected_instance_methods)  
  end

  describe ".initialize" do 
    it "creates a new receipt and sets cart to the items array of shopping cart passed in" do 

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





