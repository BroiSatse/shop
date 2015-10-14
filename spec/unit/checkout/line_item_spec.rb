describe Checkout::LineItem do
  let(:price) { 32.55 }
  let(:product) { Product::Base.new :code, 'description', price }

  subject { described_class.new product }

  describe '#initialize' do
    it 'sets the price to be equal to product price' do
      expect(subject.price).to eq price
    end
  end
end