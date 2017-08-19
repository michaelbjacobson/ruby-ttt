describe Board do

  it 'has an immutable array containing winning tile combinations' do
    winning_indices = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    expect(Board::WINNING_INDICES).to eq winning_indices
  end

  describe '@tiles' do
    context 'default tiles array' do
      it 'has an array of nine empty spaces' do
        expect(subject.tiles).to eq Array.new(9, ' ')
      end
    end

    context 'user specified tiles array' do
      it 'can be created with a user-defined tiles array' do
        example_board = %w[X X O O X O X O X]
        board = Board.new(example_board)
        board.symbols = %w[X O]
        expect(board.tiles).to eq example_board
      end
    end
  end

  describe '#display' do
    it 'prints a representation of the current game state to STDOUT' do
      board = Board.new(['X', 'O', 'X', ' ', 'O', ' ', ' ', 'X', ' '])
      board.symbols = %w[X O]
      expected_output = "\n   Game          |          Key\n" \
                        "                 |             \n" \
                        " X | O | X       |       0 | 1 | 2 \n" \
                        "---+---+---      |      ---+---+---\n" \
                        "   | O |         |       3 | 4 | 5 \n" \
                        "---+---+---      |      ---+---+---\n" \
                        "   | X |         |       6 | 7 | 8 \n" \
                        "                 |             \n\n"
      expect { board.display }.to output(expected_output).to_stdout
    end
  end

  describe '#available_tiles' do
    it 'returns an array of all available tile indices' do
      board = Board.new(['X', 'O', 'X', ' ', 'O', ' ', ' ', 'X', ' '])
      board.symbols = %w[X O]
      expect(board.available_tiles).to eq [3, 5, 6, 8]
    end
  end

  describe '#update' do
    it "updates the specified tile to contain the specified player's symbol" do
      expect(subject.tiles[0]).to eq ' '
      subject.update(0, 'X')
      expect(subject.tiles[0]).to eq 'X'
    end
  end

  describe '#reset' do
    it "resets the specified tile's contents back to a blank space" do
      expect(subject.tiles[0]).to eq ' '
      subject.update(0, 'X')
      subject.reset(0)
      expect(subject.tiles[0]).to eq ' '
    end
  end

  describe '#over?' do
    it "returns a boolean depending on whether or not the board's game is over" do
      board = Board.new
      board.symbols = %w[X O]
      expect(board.over?).to eq false
      board = Board.new(%w[X X O O X O X O X])
      board.symbols = %w[X O]
      expect(board.over?).to eq true
      board = Board.new(['X', 'O', 'X', ' ', 'O', ' ', ' ', 'X', ' '])
      board.symbols = %w[X O]
      expect(board.over?).to eq false
    end
  end

  describe '#tied?' do
    it "returns a boolean depending on whether or not the board's game is tied" do
      board = Board.new(%w[X X O O X O X O X])
      board.symbols = %w[X O]
      expect(board.tied?).to eq false
      board = Board.new(%w[X O X X O O O X X])
      board.symbols = %w[X O]
      expect(board.tied?).to eq true
    end
  end


  describe '#won?' do
    it "returns a boolean depending on whether or not the board's game is won" do
      board = Board.new(%w[X X O O X O X O X]) # X wins
      board.symbols = %w[X O]
      expect(board.won?).to eq true
      board = Board.new(%w[O O X X O X O X O]) # O wins
      board.symbols = %w[X O]
      expect(board.won?).to eq true
      board = Board.new(%w[X O X X O O O X X]) # Tie game
      board.symbols = %w[X O]
      expect(board.won?).to eq false
    end
  end

  describe '#active_player' do
    context 'there have been an even number of turns' do
      it 'returns the first player' do
        subject.symbols = %w[X O]
        subject.update(0, 'X')
        subject.update(1, 'O')
        expect(subject.active_player_symbol).to eq 'X'
      end
    end

    context 'there have been an odd number of turns' do
      it 'returns the second player' do
        subject.symbols = %w[X O]
        subject.update(0, 'X')
        expect(subject.active_player_symbol).to eq 'O'
      end
    end
  end

  describe '#full?' do
    it 'returns a boolean depending on whether or not the board is full' do
      board = Board.new(['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', ' '])
      board.symbols = %w[X O]
      expect(board.full?).to eq false
      board.update(8, 'X')
      expect(board.full?).to eq true
    end
  end

  describe '#empty?' do
    it 'returns a boolean depending on whether or not the board is empty' do
      expect(subject.empty?).to eq true
      subject.update(0, 'X')
      expect(subject.empty?).to eq false
    end
  end

  describe '#turn_count' do
    it 'returns the count of all turns played on the board' do
      subject.symbols = %w[X O]
      expect(subject.turn_count).to eq 0
      subject.update(0, 'X')
      expect(subject.turn_count).to eq 1
      subject.update(4, 'O')
      expect(subject.turn_count).to eq 2
      subject.update(1, 'X')
      expect(subject.turn_count).to eq 3
      subject.update(2, 'O')
      expect(subject.turn_count).to eq 4
      subject.update(6, 'X')
      expect(subject.turn_count).to eq 5
      subject.update(3, 'O')
      expect(subject.turn_count).to eq 6
      subject.update(5, 'X')
      expect(subject.turn_count).to eq 7
      subject.update(7, 'O')
      expect(subject.turn_count).to eq 8
      subject.update(8, 'X')
      expect(subject.turn_count).to eq 9
    end
  end

  describe '#winning_set' do

    context 'the game is not yet won' do
      it 'returns nothing' do
        expect(subject.winning_set).to eq nil
      end
    end

    context 'the game is won' do
      it 'returns an array containing the indices of the winning spaces' do
        subject.tiles = ['O', ' ', 'X', 'X', 'X', 'X', 'O', ' ', 'O']
        subject.symbols = %w[X O]
        expect(subject.winning_set).to eq [3, 4, 5]
      end
    end

  end

end
