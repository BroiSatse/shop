describe Product do
  describe '.all' do
    subject { described_class.all }

    it { is_expected.to be_an Array }
  end

  describe '.add' do
    it 'registers a new product within all array' do
      price = 30.00
      expect { described_class.add 'CODE', 'Product description', price }.to change { described_class.all.size }.by 1
    end
  end

  describe '.get_by_code' do
    let(:code) { 'CODE' }
    before { described_class.add code, 'Product description', 10.0 }

    it 'returns a product' do
      expect(described_class.get_by_code code).to be_a Product::Base
    end

    it 'returns object with given code' do
      expect(described_class.get_by_code(code).code).to eq code
    end
  end

  describe '.[]' do
    it 'is an alias of .get_by_code' do
      expect(described_class.method(:[])).to eq described_class.method(:get_by_code)
    end
  end
end
