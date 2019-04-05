require 'test/unit'
require_relative '../lib/three_for_two_deal.rb'
require_relative '../lib/checkout.rb'

class ThreeForTwoDealTest < Test::Unit::TestCase
  def setup
    @rule      = ThreeForTwoDeal.new('atv')
    @checkout  = Checkout.new([@rule])
    @store     = @checkout.store
    @atv       = @store.find('atv')
    @ipd       = @store.find('ipd')
    mbp        = @store.find('mbp')
    @ipd_one   = Item.new(@ipd.code, @ipd.price)
    @ipd_two   = Item.new(@ipd.code, @ipd.price)
    @ipd_three = Item.new(@ipd.code, @ipd.price)
    @ipd_four  = Item.new(@ipd.code, @ipd.price)
    @ipd_five  = Item.new(@ipd.code, @ipd.price)
    @atv_one   = Item.new(@atv.code, @atv.price)
    @atv_two   = Item.new(@atv.code, @atv.price)
    @atv_three = Item.new(@atv.code, @atv.price)
    @atv_four  = Item.new(@atv.code, @atv.price)
    mbp_one    = Item.new(mbp.code, mbp.price)
  end

  def test_rule_application_without_items_to_apply_discount
    items = [ @ipd_one, mbp_one ]
    @rule.apply(items)
    assert_equal @ipd_one.price, @ipd_one.price, "Item price didn't change"
    assert_equal mbp_one.price, mbp_one.price, "Item price didn't change"
  end

  def test_when_checkout_has_an_even_number_of_products_to_apply_three_for_two_discount
    items = [@ipd_one, @ipd_two, @atv_one, @atv_two, mbp_one]
    @rule.apply(items)
    assert_equal @ipd_one.price, @ipd.price, "Item price didn't change"
    assert_equal @ipd_two.price, @ipd.price, "Item price didn't change"
    assert_equal @atv_one.price, @atv.price, "Item price didn't change"
    assert_equal @atv_two.price, 0, "Item price now is zero"
    assert_equal @mug_one.price, @mug_one.price, "Item price didn't change"
  end

  def test_when_checkout_has_an_odd_number_of_products_to_apply_three_for_two_discount
    items = [@ipd_one, @ipd_two, @atv_one, @atv_two, @atv_three, @mug_one]
    @rule.apply(items)
    assert_equal @ipd_one.price, @ipd.price, "Item price didn't change"
    assert_equal @ipd_two.price, @ipd.price, "Item price didn't change"
    assert_equal @atv_one.price, @atv.price, "Item price didn't change"
    assert_equal @atv_two.price, 0, "Item price now is zero"
    assert_equal @atv_three.price, @atv.price, "Item price didn't change"
    assert_equal @mug_one.price, @mug_one.price, "Item price didn't change"
  end
end
