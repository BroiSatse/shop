module Checkout
  module Discount
    class TwoForOne < Base
      def process!(list)
        qualifying_items = list.group_by(&:product).find {|k, _| k.code == @options[:code] }.last
        qualifying_items.each_with_index do |item, index|
          item.price = 0 unless index % 2 == 0
        end
      end
    end
  end
end