# PROBLEM TWO: SALES TAX

This application solves the sales tax problem by simulating an actual shopping experience. 

The app has three classes: Item, ShoppingCart, Receipt. Each class is an abstraction of the real-world object it derives its name from. 

The Item class is responsible for creating new items and storing the name, price, taxable, and imported attributes. This class determines the sales tax of each item based on if it is taxable or tax-exempt (food, books, and medicial supplies) and if it is imported.

The ShoppingCart class creates a cart in which to store items. Items can be added to and removed from the shopping cart, the quanity of a specific item in the cart can be changed, and the cart's contents can be viewed. When a user is finished shopping, the shopping cart is purchased, and a receipt is printed.

The Receipt class is responsible for calculating the shopping cart sales tax and grand total. It is through this class that a receipt is printed out.

To run the app:

I have supplied the Input data in the main.rb file. To run this test data, simply load the main.rb file in the console. 

To create a custom shopping experience:

Items can be created by the following syntax:

  Item.new(name, price, taxable = false, imported = false)
  new_item = Item.new("item_name", 10.0)

The item name and price must be passed in. To set an item as taxable, pass in true for that argument. To set an item as imported, pass in true for that argument. Taxable and imported default to false if no arguments are passed.

The following methods can be called on an item:
