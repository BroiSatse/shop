describe Checkout::Discount::ThresholdDiscount do
  let(:code) { :CD1 }
  let(:threshold) { 4 }
  let(:discount) { 2.5 }

  let(:list) {
    [
        Checkout::LineItem.new(Product[:CD1]),
        Checkout::LineItem.new(Product[:CD2]),
        Checkout::LineItem.new(Product[:CD1]),
        Checkout::LineItem.new(Product[:CD2]),
        Checkout::LineItem.new(Product[:CD1]),
    ]
  }

  subject { described_class.new(code: code, threshold: threshold, discount: discount) }

  before do
    Product.add(:CD1, 'description', 10.00)
    Product.add(:CD2, 'other product', 4.20)
  end

  context 'when there are lass items in the list than given threshold' do
    it 'does not affect prices' do
      expect { subject.process!(list) }.not_to change { list.map(&:price) }
    end
  end

  context 'when there at least that many items in the list as given threshold' do
    let(:threshold) { 3 }
    it 'does not affect prices' do
      expect { subject.process!(list) }.to change { list.map(&:price) }.to [7.5, 4.2, 7.5, 4.2, 7.5]
    end
  end
end