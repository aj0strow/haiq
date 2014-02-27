describe Haiku do
  let(:haiku) { Fabricate(:haiku) }

  describe '#valid?' do
    specify 'user required' do
      haiku.user = nil
      expect(haiku).not_to be_valid
    end

    specify 'first line 5 syllables' do
      haiku.first = 'hello'
      expect(haiku).not_to be_valid
    end

    specify 'second line 7 syllables' do
      haiku.second = 'hello'
      expect(haiku).not_to be_valid
    end

    specify 'third line 5 syllables' do
      haiku.third = 'hello hello hello'
      expect(haiku).not_to be_valid
    end

    specify 'only real words allowed' do
      haiku.first = 'cannot fux tho eh'
      expect(haiku).not_to be_valid
    end
  end

  describe 'formatting' do
    it 'should remove whitespace' do
      first = haiku.first
      haiku.first = '   ' + first
      haiku.save
      expect(haiku.first).to eq(first)
    end
  end
end
