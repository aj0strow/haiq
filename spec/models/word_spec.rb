describe Word do
  describe '#syllables' do
    specify 'hello -> 2' do
      expect(Word.new('hello').syllables).to eq(2)
    end

    specify 'yee -> error' do
      expect{ Word.new('yee').syllables }.to raise_error(ArgumentError)
    end
  end
end
