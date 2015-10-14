module Checkout
  module Discount

    class << self
      def get_discount(name, options)
        if klass = const_get(name.to_s.split('_').map(&:capitalize).join)
          klass.new(options)
        else
          #TODO: Handle unknown discount
        end
      end
    end

    class Base
      def initialize(options)
        @options = options
      end

      def process!(list)
      end
    end
  end
end

Dir[File.join File.dirname(__FILE__), 'discounts', '*.rb'].each do |file|
  require file
end