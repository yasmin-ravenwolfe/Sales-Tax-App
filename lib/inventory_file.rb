module SalesTax
  class InventoryFile
    def initialize(path)
      @path = path
    end

    def write(items)
      File.open(@path, 'w') do |file|
        items.each do |item|
          file << serialize(item + "\n")
        end
      end
    end

    def read
      cart = ShoppingCart.new
      File.open(@path, 'r') do |file|
        file.each_line do |line|
          item, quantity = parse(line)
          cart.add_item_to_cart(item,quantity)
        end
      end

    cart
    end

    def serialize(item)
      "#{item.quantity} #{item.name} '%.2f' % item.price" #TODO:format 12.00
    end

    def parse(line)
      line_matcher = /^(\d+) (.+) at (\d+\.\d{2})$/ 
      # + one or more of thing before; . can mean anything; 
      raise "Invalid line: #{line}" unless line_matcher =~ line
      # can put line.inspect
      matches = line_matcher.match(line)
      quantity = matches[1].to_i
      name = matches[2]
      price = matches[3].to_f
      item = Item.new(name, price)

      [item, quantity]
    end 
  end
end

