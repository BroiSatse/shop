describe Checkout::Discount::TwoForOne do
  let(:code) { :CD1 }
  before do
    Product.add(:CD1, 'description', 10.00)
    Product.add(:CD2, 'other product', 7.20)
    subject.process!(list)
  end

  let(:list) {
    [
        Checkout::LineItem.new(Product[:CD1]),
        Checkout::LineItem.new(Product[:CD2]),
        Checkout::LineItem.new(Product[:CD1]),
        Checkout::LineItem.new(Product[:CD2]),
        Checkout::LineItem.new(Product[:CD1]),
        Checkout::LineItem.new(Product[:CD1])
    ]
  }
  subject { described_class.new(code: code) }

  it 'reduces the price of every second product with given price to zero' do
    expect(list[2].price).to eq 0
    expect(list[5].price).to eq 0
  end

  it 'does not reduce price of first items in the pair' do
    expect(list[0].price).to eq 10.0
    expect(list[4].price).to eq 10.0
  end

  it 'does not reduce price of non-matching items' do
    expect(list[1].price).to eq 7.2
    expect(list[3].price).to eq 7.2
  end

end