describe Human do

  it 'inherits from the Player class' do
    expect(Human.superclass.name).to eq 'Player'
  end

  it 'is initialized with one argument, a playing symbol' do
    human = Human.new
    human.symbol = 'X'
    expect(human.symbol).to eq 'X'
  end

  describe '#make_move' do
    it "sends the player's selected move to the board" do
      board = double(:board, available_tiles: [0, 1, 2, 3, 4, 5, 6, 7, 8])
      human = Human.new
      human.symbol = 'X'
      allow($stdin).to receive(:gets).and_return('8')
      expect(board).to receive(:update)
      human.make_move(board)
    end
  end
end
