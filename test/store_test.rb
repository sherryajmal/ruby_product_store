require 'test/unit'
require_relative '../lib/store.rb'

class StoreTest < Test::Unit::TestCase

  def setup
    ipd    = Product.new('ipd', 'Super iPad', 549.99)
    mbp    = Product.new('mbp', 'MacBook Pro', 1399.99)
    atv    = Product.new('atv', 'Apple TV', 109.50)
    vga    = Product.new('vga', 'VGA adapter', 30.00)
    @store = Store.new(ipd, mbp, atv, vga)
  end

  def test_that_quantity_of_products_is_correct
    assert_equal 4, @store.products_quantity, 'The store has 4 products'
  end

  def test_valid_codes_method
    codes = []
    valid_codes = @store.valid_codes
    @store.products.each{ |product| codes.push(product.code) }
    assert_equal codes, valid_codes
  end
end