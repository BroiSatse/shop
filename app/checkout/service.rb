module Checkout
  class Service

    def list
      @list ||= []
    end

    def scan(code)
      if product = Product[code]
        list << LineItem.new(product)
      else
        # TODO: handle unknowns codes
      end
    end

    def total
      list.inject(0) {|sum, item| sum + item.price }
    end
  end
end