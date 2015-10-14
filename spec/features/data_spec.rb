describe 'acceptance criteria' do
  let(:basket) { [] }
  let(:checkout) do
    Checkout::Service.new(
      two_for_one: { code: :FR1 },
      threshold_discount: { code: :SR1, threshold: 3, discount: 0.50 }
    )
  end
  let(:total_price) { checkout.total }

  before do
    # Loading test product, so we don't rely on real prices
    Product.add(:FR1, 'Fruit tea', 3.11)
    Product.add(:SR1, 'Strawberries', 5.0)
    Product.add(:CF1, 'Coffee', 11.23)
  end

  example_data = [
      {
          product_codes: [:FR1, :SR1, :FR1, :FR1, :CF1],
          expected_total: 22.45
      },
      {
          product_codes: [:FR1, :FR1],
          expected_total: 3.11
      },
      {
          product_codes: [:SR1, :SR1, :FR1, :SR1,],
          expected_total: 16.61
      }
  ]

  example_data.each do |data|
    it 'is correct for first acceptance criteria' do
      data[:product_codes].each {|code| checkout.scan code }
      expect(total_price).to eq data[:expected_total]
    end
  end
end