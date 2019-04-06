require_relative 'lib/checkout.rb'
require_relative 'lib/discount_deal.rb'
require_relative 'lib/three_for_two_deal.rb'


def breakline
  puts "\n"
end

def prompt
  print '>> '
end

@rule_one   = ThreeForTwoDeal.new('atv')
@rule_two   = DiscountDeal.new('ipd', 4, 50.00)
@checkout   = Checkout.new([ @rule_one, @rule_two])

@store      = @checkout.store

option      = 0
while option != 6
  puts """
    Welcome to Droidox Computer Store

    1. Inventory
    2. Update product
    3. Scan product
    4. Total
    5. Exit
  """
  prompt

  option = gets.chomp.to_i
  breakline

  case option
  when 1
    puts @store.list

  when 2
    puts 'Please enter SKU of the product you want to update:'
    prompt
    code    = gets.chomp
    product = @store.find(code)
    prompt
    puts 'Please enter new name:'
    prompt
    name    = gets.chomp
    puts 'Please enter new price:'
    prompt
    price   = gets.chomp.to_f

    @store.update(product, code, name, price)
    breakline
    puts 'The next product was updated successfully'
    puts product.to_s
  when 3
    puts 'Please enter SKU:'
    prompt
    code    = gets.chomp

    breakline
    puts @checkout.scan(code) ? 'The product was added successfully' : 'This product does not exist'
  when 4
    @checkout.show
  when 5
    puts 'Good Bye!'
  else
    puts 'Please select a correct option'
  end
end