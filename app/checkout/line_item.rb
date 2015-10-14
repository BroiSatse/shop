module Checkout
  class LineItem
    attr_reader :product
    attr_accessor :price

    def initialize(product)
      @product, @price = product, product.price
    end
  end
end