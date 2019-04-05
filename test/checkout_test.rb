require 'test/unit'
require_relative '../lib/checkout.rb'
require_relative '../lib/discount_deal.rb'
require_relative '../lib/three_for_two_deal.rb'

class CheckoutTest < Test::Unit::TestCase

  def setup
    @rule_one = ThreeForTwoDeal.new('atv')
    @rule_two = DiscountRule.new('ipd', 4, 50.0)
    @checkout = Checkout.new([ @rule_one, @rule_two ])
    @store    = @checkout.store
  end

  def test_when_checkout_scan_a_new_product
    assert_equal @checkout.scan("ipd"), true
    assert_equal @checkout.scan("PEN"), false
    assert_equal @checkout.scan("vga"), true
    assert_equal @checkout.scan("mbp"), true
    assert_equal @checkout.scan("atv"), true
    assert_equal @checkout.scan("CAR"), false
  end

  def test_that_total_works_correcty_without_apply_promotions_and_invalid_codes
    @checkout.scan('ipad')
    @checkout.scan('GLASSES')
    @checkout.scan('vga')
    @checkout.scan('INVITATION')
    @checkout.scan('atv')
    assert_equal 689.49, @checkout.total
  end

  def test_checkout_example_one
    @checkout.scan('ipad')
    @checkout.scan('vga')
    @checkout.scan('atv')
    assert_equal 689.49, @checkout.total
  end
end
