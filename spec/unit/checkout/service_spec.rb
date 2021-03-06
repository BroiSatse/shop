describe Checkout::Service do
  let(:options) { {} }
  subject { described_class.new options }

  describe '#scan' do
    let(:code) { :code }
    let(:product) { Product::Base.new code, 'description', 20.0 }

    before { allow(Product).to receive(:[]).with(code).and_return product }

    it 'creates a new LineItem' do
      expect(Checkout::LineItem).to receive(:new).with product
      subject.scan :code
    end

    it 'adds a new element to checkout list' do
      expect { subject.scan :code }.to change { subject.list.size }.by 1
    end
  end

  describe '#total' do
    let(:list) { 10.times.map { FakeLineItem.new } }
    let(:total_price) { list.map(&:price).inject(0, &:+) }
    before { allow(subject).to receive(:list).and_return list }

    it 'returns the sum of prices of all items in the list' do
      expect(subject.total).to eq total_price
    end
  end

  describe '#list' do
    let(:discount) { double }
    let(:options) {{ discount: :mocked }}

    before { allow(Checkout::Discount).to receive(:get_discount).and_return discount }
    before { allow(discount).to receive(:process!) {|list| list.each {|item| item.price = :discounted }}}

    before do
      Product.add(:CODE, 'description', 15.00)
      rand(3..6).times { subject.scan :CODE }
    end

    it 'returns a list with all discounts applied' do
      expect(subject.list.map(&:price).uniq).to eq [:discounted]
    end

  end

  class FakeLineItem
    attr_accessor :price

    def initialize
      @price = rand(100..2000) / 100
    end
  end
end