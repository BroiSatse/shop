module Checkout
  class Service

    attr_reader :original_list

    def initialize(rules = {})
      @rules = rules
      @original_list = []
    end

    def scan(code)
      if product = Product[code]
        @original_list << LineItem.new(product)
        @discounted_list = nil
      else
        # TODO: handle unknowns codes
      end
    end

    def total
      list.inject(0) {|sum, item| sum + item.price }
    end

    def list
      return @discounted_list if @discounted_list
      @discounted_list ||= @original_list.dup
      @rules.each {|name, options|
        Checkout::Discount.get_discount(name, options).process! @discounted_list
      }
      @discounted_list
    end
  end
end