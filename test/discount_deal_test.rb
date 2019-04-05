require 'test/unit'
require_relative '../lib/discount_deal.rb'
require_relative '../lib/checkout.rb'

class DiscountDealTest < Test::Unit::TestCase
  def setup
    @rule         = DiscountDeal.new('ipd', 4, 50.0)
    @checkout     = Checkout.new([@rule])
    @store        = @checkout.store
    @atv          = @store.find('atv')
    @ipd          = @store.find('ipd')
    @mbp          = @store.find('mbp')
    @ipd_one      = Item.new(@ipd.code, @ipd.price)
    @ipd_two      = Item.new(@ipd.code, @ipd.price)
    @ipd_three    = Item.new(@ipd.code, @ipd.price)
    @ipd_four     = Item.new(@ipd.code, @ipd.price)
    @ipd_five     = Item.new(@ipd.code, @ipd.price)
    @atv_one      = Item.new(@atv.code, @atv.price)
    @mbp_one      = Item.new(@mbp.code, @mbp.price)
  end

  def test_rule_application_without_items_to_apply_discount
    items = [ @atv_one, @mbp_one ]
    @rule.apply(items)
    assert_equal @atv_one.price, @atv.price, "Item price didn't change"
    assert_equal @mbp_one.price, @mbp.price, "Item price didn't change"
  end

  def test_rule_application_without_enough_quantity_to_apply_discount
    items = [ @ipd_one, @ipd_two, @atv_one, @mbp_one ]
    @rule.apply(items)
    assert_equal @ipd_one.price, @ipd.price, "Item price didn't change"
    assert_equal @ipd_two.price, @ipd.price, "Item price didn't change"
    assert_equal @atv_one.price, @atv.price, "Item price didn't change"
    assert_equal @mbp_one.price, @mbp.price, "Item price didn't change"
  end
 
end