describe Human do

  it 'inherits from the Player superclass' do
    expect(subject).to respond_to(:ai?, :symbol)
  end

  describe '#choose_move' do
    it "takes the human player's input, from the specified input stream, and returns it" do
      test_input = StringIO.new('test string')
      expect(subject.choose_move(input: test_input)).to match /test string/
    end
  end
end
