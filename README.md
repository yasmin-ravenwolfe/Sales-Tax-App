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

Write an application that prints out the receipt details for these shopping baskets...
INPUT:
 
Input 1:
1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
 
Input 2:
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
 
Input 3:
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
1 box of imported chocolates at 11.25
 
OUTPUT
 
Output 1:
1 book : 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83
 
Output 2:
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
 
Output 3:
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
1 imported box of chocolates: 11.85
Sales Taxes: 6.70
Total: 74.68