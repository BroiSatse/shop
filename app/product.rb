module Product
  class << self
    def all
      @all ||= []
    end

    def add(code, name, price)
      all << Base.new(code, name, price)
    end

    def get_by_code(code)
      all.find {|product| product.code == code }
    end

    def reset!
      @all = []
    end

    alias :[] :get_by_code
  end

  class Base < Struct.new(:code, :name, :price)
  end
end