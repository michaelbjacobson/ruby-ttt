describe Computer do

  before(:each) do
    @players = %w[X O]
    @board = double(
      :board,
      tied?: false,
      won?: false,
    )
    @computer = Computer.new
    @computer.symbol = 'O'
  end

  it 'has an immutable array containing possible opening moves' do
    expect(Computer::OPENING_GAMBITS).to eq(%w[0 2 6 8])
  end

  describe '#choose_starting_move' do
    it 'returns an opening gambit' do
      expect(@computer.choose_starting_move)
        .to match(/[#{Computer::OPENING_GAMBITS.join}]/)
    end
  end

  describe '#make_move' do

    context 'the board is empty' do
      it 'plays an opening move' do
        allow(@board).to receive(:empty?).and_return(true)
        expect(@computer).to receive(:choose_starting_move)
        expect(@board).to receive(:update)
        @computer.make_move(@board)
      end
    end

    context 'the board is not empty' do
      it 'plays the next best move' do
        allow(@board).to receive(:empty?).and_return(false)
        expect(@board).to receive(:update)
        expect(@computer).to receive(:calculate_best_move)
        @computer.make_move(@board)
      end
    end
  end

end