require_relative 'store'
require_relative 'item'

class Checkout
  attr_reader :total, :store, :items

  def initialize(pricing_rules)
    @rules       = pricing_rules
    ipd          = Product.new('ipd', 'Super iPad', 549.99)
    mbp          = Product.new('mbp', 'MacBook Pro', 1399.99)
    atv          = Product.new('atv', 'Apple TV', 109.50)
    vga          = Product.new('vga', 'VGA adapter', 30.00)
    @store       = Store.new(ipd, mbp, atv, vga)
    @items       = []
    @valid_codes = @store.valid_codes
  end

  def scan(code)
    if @valid_codes.include?(code)
      if code == 'mbp'
        product = @store.find(code)
        item    = Item.new(product.code, product.price)
        vga     = @store.find('vga')
        free    = Item.new(vga.code, 0.0)
        @items.push(item, free)
      else
        product = @store.find(code)
        item    = Item.new(product.code, product.price)
        @items.push(item)
      end
        true
    else
      false
    end
  end

  def show
    items = @items.map(&:code).join(', ')
    puts items.size > 0 ? "Items: #{items}" : 'No items to checkout'
    puts "Total: $#{self.total}"
  end

  def total
    @rules.each{ |rule| rule.apply(@items) }
    @items.inject(0.0){ |total, item| total += item.price}
  end
end
