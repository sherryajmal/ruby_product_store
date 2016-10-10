require 'terminal-table'
require_relative 'product'
require 'byebug'

class Store
  def initialize
    @products = {
      'VOUCHER': Product.new('VOUCHER', 'Cabify Voucher', 5.0),
      'TSHIRT': Product.new('TSHIRT', 'Cabify T-Shirt', 20.0),
      'MUG': Product.new('MUG', 'Cafify Coffee Mug', 7.5)
    }
  end

  # def find(code)
  #   @products.key?(code)
  # end

  # def create(product)

  # end

  def products_quantity
    @products.size
  end

  def list
    Terminal::Table.new(title: "Cabify's Store", headings: [ 'Code', 'Name', 'Price'], rows: to_a)
  end

  private
  # Returns all the products as array of arrays
  def to_a
    products = []
    @products.each do |code, product|
      products.push(product.to_a)
    end
    products
  end
end