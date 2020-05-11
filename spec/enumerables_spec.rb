require './lib/enumerables.rb'

RSpec.describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5] }
  describe '#my_each' do
    it 'belongs to the enumerator class' do
      expect(arr.my_each.class).to eq(Enumerator)
    end
  end
  describe '#my_each_with_index' do
    it 'belongs to the enumerator class' do
      expect(arr.my_each_with_index.class).to eq(Enumerator)
    end
  end
  describe '#my_select' do
    it 'belongs to the enumerator class' do
      expect(arr.my_select.class).to eq(Enumerator)
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
      expect([nil, true, 99].my_any?(Integer)).to eq true
    end
    it 'returns false when called on empty object' do
      expect([].my_any?).to eq(false)
    end
    it 'returns true if at least one object is truthy' do
      expect([nil, true, 99].my_any?).to eq(true)
    end
  end
  describe '#my_none?' do
    it 'returns true if none meets the condition set' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 5 }).to eql(true)
    end
    it 'returns false if 1 or more items meets the condition set' do
      expect(%w[bear ant cat].my_none? { |word| word.length > 3 }).to eql(false)
    end
    it 'returns true if no item matches a pattern set' do
      expect([nil, true, 99].my_none?(String)).to eq true
    end
    it 'returns true when called on empty object' do
      expect([].my_none?).to eq(true)
    end
    it 'returns true if all objects are falsey' do
      expect([nil, false].none?).to eq(true)
    end
  end
  describe '#my_inject' do
    it 'return product of all elements' do
      expect([2, 3, 4].my_inject(:*)).to eq(2 * 3 * 4)
    end
    it 'return sum of all elements and accumulator value' do
      expect([2, 3, 4].my_inject(2, :+)).to eq(2 + 2 + 3 + 4)
    end
    it 'yields with args' do
      expect { |b| [2, 3, 4].my_inject(&b) }.to yield_with_args
    end
    it 'belongs to the enumerator class' do
      expect([2, 3, 4].my_inject.class).to eq(Enumerator)
    end
    # it "elements receive my_each" do
    # allow { |b| [2,3,4].my_inject(&b) }.to receive( expect{ |b| [2,3,4].my_each(&b) }.to yield_with_args)
    # end
  end
  describe '#my_map' do
    it 'if block is given returns a new array' do
      expect([2, 3, 4].my_map { |i| i * 2 }).to eq([4, 6, 8])
    end
    it 'if block not given returns my_each ' do
      allow([2, 3, 4]).to receive(:my_map).and_return(:my_each)
    end
    it 'returns an enumerator if no object is given' do
      expect((1..4).my_map {"cat"}).to eq(["cat", "cat", "cat", "cat"])
    end
  end
  describe '#my_count' do
    it 'if neither block given nor arg given returns size' do
      expect([2, 3, 4].my_count).to eq([2, 3, 4].size)
    end
    it 'counts the number of elements yielding a true value when a block is given' do
      expect([2, 3, 4].my_count(&:even?)).to eq(2)
    end
    it 'counts items in enum that are equal to arg' do
      expect([2, 3, 4].my_count(2)).to eq(1)
    end
  end
end
