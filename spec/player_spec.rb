describe Player, fast: true do
  describe '#ai?' do
    it 'returns false by default' do
      expect(subject.ai?).to eq false
    end
  end
end
