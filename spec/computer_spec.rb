describe Computer do

  describe '#ai?' do
    it 'returns true' do
      expect(subject.ai?).to eq true
    end
  end

  describe '#opening_gambit' do
    context 'the board is 3 tiles wide' do
      it 'returns either 0, 2, 6, or 8' do
        board = double('board', corners: [0, 2, 6, 8])
        expect(subject.send(:opening_gambit, board).to_s).to match /[0268]/
      end
    end
    context 'the board is 4 tiles wide' do
      it 'returns either 0, 3, 12, or 15' do
        large_board = double('board', corners: [0, 3, 12, 15])
        expect(subject.send(:opening_gambit, large_board).to_s).to match /(0|3|12|15)/
      end
    end
  end
end