require './lib/enumerables.rb'

RSpec.describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  describe '#my_each' do
    it 'returns same thing as Ruby\'s .each method' do
      expect(arr.my_each.class).to eq(arr.each.class)
    end
  end
  describe '#my_each_with_index' do
    it 'returns same thing as Ruby\'s .each_with_index method' do
      expect(arr.my_each_with_index.class).to eq(arr.each_with_index.class)
    end
  end
  describe '#my_select' do
    it 'returns same thing as Ruby\'s .select method' do
        expect(arr.my_select.class).to eq(arr.select.class)
    end
  end
  describe '#my_all?' do
    it 'returns true if everything in array meets the criteria' do
        expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(true)
    end
    it 'returns false if not everything meets the criteria' do
        expect(%w[ant bear cats].my_all? { |word| word.length >= 4 }).to eq(false)
    end
    it 'returns false when it encounters any nil value' do
        expect([nil, true, 99].my_all?).to eq(false)
    end
    it 'accepts a pattern' do
        expect([1, 2i, 3.14].my_all?(Numeric)).to eq(true)
    end
    it 'returns true for an empty array' do
        expect([].my_all?).to eq(true)
    end
  end
  describe '#my_any?' do
    it 'returns true if atleast 1 item meets the condition set' do
        expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it 'returns false if not even 1 item meets the condition set' do
        expect(%w[ant bear cat].my_any? { |word| word.length > 4 }).to eql(false)
    end
    it 'returns true if any item matches a pattern set' do
        expect([nil, true, 99].my_any?(Integer)).to eq (true)
    end
    it 'returns false when called on empty object' do
        expect([].my_any?).to eq(false)
    end
    it 'returns true if at least one object is truthy' do
        expect([nil, true, 99].my_any?).to eq(true)
    end

  end
end
