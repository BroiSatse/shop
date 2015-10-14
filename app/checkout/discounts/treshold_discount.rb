module Checkout
  module Discount
    class ThresholdDiscount < Base
      def process!(list)
        qualifying_items = list.group_by {|item| item.product.code}[@options[:code]]
        return unless qualifying_items && qualifying_items.length >= @options[:threshold]
        qualifying_items.each do |item|
          item.price -= @options[:discount]
        end
      end
    end
  end
end