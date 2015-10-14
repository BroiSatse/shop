describe 'acceptance criteria' do
  let(:basket) { [] }
  let(:checkout) { Checkout::Service.new }
  let(:total_price) { checkout.total }

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
      total_price.should eq data[:expected_total]
    end
  end
end