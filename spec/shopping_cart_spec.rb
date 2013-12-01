require 'rubygems'
require 'bundler/setup'
require 'rspec'

require_relative '../lib/shopping_cart'

module SalesTax
  describe ShoppingCart do
    let(:cart) {ShoppingCart.new}
    let(:item) {Item.new("chocolate", 10.0)}
    
    describe ".initialize" do 
      it "creates a new shopping cart and sets items to an empty set" do 

        expect(cart.items).to eq(Set.new)
      end
    end

    describe "#add_item_to_cart" do 
      it "adds item to cart items set and updates the item's quantity in cart" do

        cart.add_item_to_cart(item, 2)

        expect(item.quantity).to eq(2)
      end
    end

    describe "#remove_item_from_cart" do 
      context "when item is found in cart" do 
        it "removes item from cart items set and updates the item's quantity in cart" do 

          cart.add_item_to_cart(item)
          cart.remove_item_from_cart(item)

          expect(cart.items.inspect).to eq("#<Set: {}>")
          expect(item.quantity).to eq(0)
        end
      end
      context "when item is not found in cart" do
        it "returns an error message" do 

          item2 = Item.new("bar",1.0)

          expect(cart.remove_item_from_cart(item2)).to eq("Item not found in shopping cart.")
        end
      end
    end

    describe "#update_quantity_in_cart" do 
      context "when item is found in cart" do 
        it "updates the item's quantity in cart" do 

          cart.add_item_to_cart(item)
          cart.update_quantity_in_cart(item, 3)

          expect(item.quantity).to eq(3)
        end
      end

      context "when item is not found in cart" do
        it "returns an error message" do

          expect(cart.update_quantity_in_cart(item, 3)).to eq("#{item.name.capitalize} not found in shopping cart. Please add it before updating quantity.")
        end
      end
    end

    describe "#view_cart" do 
      context "when shopping cart is empty" do
        it "returns an error message" do

          expect(cart.view_cart).to eq("Your shopping cart is empty. Please add some items.")
        end
      end
      context "when cart items array is not empty" do
        it "returns the items in cart" do 
          cart.add_item_to_cart(item, 2)

          expect(cart.view_cart).to eq(cart.items)
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
end
