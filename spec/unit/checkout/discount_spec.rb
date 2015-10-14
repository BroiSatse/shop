describe Checkout::Discount do
  let(:fake_discount_class) { double(Class) }
  let(:fake_discount) { double }
  let(:options) {{ some: :hash }}

  describe '.get_discount' do
    it 'returns a new instance of matching discount class instantiated with given options' do
      described_class::ConstantName = fake_discount_class

      expect(fake_discount_class).to receive(:new).with(options).and_return fake_discount
      expect(described_class.get_discount :constant_name, options).to eq fake_discount
    end
  end
end