describe Board, fast: true do

  describe '#available_tiles' do # it returns an array containing the indices of all available tiles on the board
    context 'all tiles are available' do
      it 'returns [0, 1, 2, 3, 4, 5, 6, 7, 8]' do
        expect(subject.available_tiles).to eq [0, 1, 2, 3, 4, 5, 6, 7, 8]
      end
    end
    context 'tiles at all even indices are occupied by a player symbol' do
      it 'returns [1, 3, 5, 7]' do
        subject.tiles.map!.with_index { |tile, index| tile = subject.symbols[0] if index.even? }
        expect(subject.available_tiles).to eq [1, 3, 5, 7]
      end
    end
    context 'tiles at all odd indices are occupied by a player symbol' do
      it 'returns [0, 2, 4, 6, 8]' do
        subject.tiles.map!.with_index { |tile, index| tile = subject.symbols[0] if index.odd? }
        expect(subject.available_tiles).to eq [0, 2, 4, 6, 8]
      end
    end
    context 'all tiles are occupied by player symbols, the board is full' do
      it 'returns an empty array' do
        subject.tiles.map!.with_index { |tile, index| index.even? ? tile = subject.symbols[0] : tile = subject.symbols[1] }
        expect(subject.available_tiles).to eq []
      end
    end
  end

  describe '#empty?' do
    context 'the board is empty, no moves have been made yet' do
      it 'returns true' do
        expect(subject.empty?).to eq true
      end
    end
    context 'the board is no longer empty, at least one move has been made' do
      it 'returns false' do
        subject.tiles[0] = subject.symbols[0]
        expect(subject.empty?).to eq false
      end
    end
  end

  describe '#full?' do
    context 'the board is not full, at least one tile is still vacant' do
      it 'returns false' do
        expect(subject.full?).to eq false
      end
    end
    context 'the board is full, each tile is occupied by a player symbol' do
      it 'returns true' do
        subject.tiles.map!.with_index { |tile, index| index.even? ? tile = subject.symbols[0] : tile = subject.symbols[1] }
        expect(subject.full?).to eq true
      end
    end
  end

  describe '#turn_count' do
    it 'returns the total number of turns that have been made' do
      expect(subject.turn_count).to eq 0
      subject.tiles[0] = subject.symbols[1]
      expect(subject.turn_count).to eq 1
      subject.tiles.map!.with_index { |tile, index| tile = subject.symbols[0] if index.odd? }
      expect(subject.turn_count).to eq 4
      subject.tiles.map!.with_index { |tile, index| tile = subject.symbols[0] if index.even? }
      expect(subject.turn_count).to eq 5
      subject.tiles.map!.with_index { |tile, index| index.even? ? tile = subject.symbols[0] : tile = subject.symbols[1] }
      expect(subject.turn_count).to eq 9
    end
  end

  describe '#active_player_symbol' do # it returns either the first or the second player symbol, depending on whether the turn count is odd or even
    context "player 'X' is going first, there have been an even number of turns" do
      it "returns 'X'" do
        expect(subject.active_player_symbol).to eq 'X'
      end
    end
    context "player 'O' is going first, there have been an even number of turns" do
      it "returns 'O'" do
        subject.symbols.rotate!
        expect(subject.active_player_symbol).to eq 'O'
      end
    end
    context "player 'X' is going first, there have been an odd number of turns" do
      it "returns 'O'" do
        subject.tiles[0] = 'X'
        expect(subject.active_player_symbol).to eq 'O'
      end
    end
    context "player 'O' is going first, there have been an odd number of turns" do
      it "returns 'X'" do
        subject.symbols.rotate!
        subject.tiles[0] = 'O'
        expect(subject.active_player_symbol).to eq 'X'
      end
    end
  end

  describe '#update' do
    it "places the current player's symbol onto the tile at the specified index" do
      subject.update(0)
      expect(subject.tiles[0]).to eq 'X'
      subject.update(1)
      expect(subject.tiles[1]).to eq 'O'
    end
    it 'will not overwrite an already occupied tile' do
      subject.update(0)
      expect(subject.tiles[0]).to eq 'X'
      subject.update(0)
      expect(subject.tiles[0]).to eq 'X'
    end
  end

  describe '#reset' do
    it "removes any player symbols from the tile at the specified index and resets it to it's original state" do
      expect(subject.tiles[0]).to eq 0
      subject.update(0)
      expect(subject.tiles[0]).to eq 'X'
      subject.reset(0)
      expect(subject.tiles[0]).to eq 0
    end
    it 'will have no effect on a tile that does not contain a player symbol' do
      expect(subject.tiles[0]).to eq 0
      subject.reset(0)
      expect(subject.tiles[0]).to eq 0
    end
  end

  describe '#won?' do
    context 'a player symbol is given as a method argument' do
      it "returns a boolean value depending on whether or not the specified player symbol has won the game, ie. they've occupied a full set of winning indices" do
        expect(subject.won?('X')).to eq false
        subject.tiles[0] = 'X'
        subject.tiles[1] = 'X'
        subject.tiles[2] = 'X'
        expect(subject.won?('X')).to eq true
        expect(subject.won?('O')).to eq false
      end
    end
    context "no argument is given to the method when it's called" do
      it "returns a boolean value depending on whether or not either of the player symbols has won the game, ie. they've occupied a full set of winning indices" do
        expect(subject.won?).to eq false
        subject.tiles[6] = 'O'
        subject.tiles[7] = 'O'
        subject.tiles[8] = 'O'
        expect(subject.won?).to eq true
        subject.reset(6)
        expect(subject.won?).to eq false
        subject.tiles[6] = 'X'
        subject.tiles[7] = 'X'
        subject.tiles[8] = 'X'
        expect(subject.won?).to eq true
      end
    end
  end

  describe '#lost' do
    it 'returns a boolean value depending on whether or not the specified player has lost the game, ie. the other player has won' do
      subject.tiles[3] = 'O'
      subject.tiles[4] = 'O'
      subject.tiles[5] = 'O'
      expect(subject.lost?('O')).to eq false
      expect(subject.lost?('X')).to eq true
      subject.tiles[3] = 'X'
      subject.tiles[4] = 'X'
      subject.tiles[5] = 'X'
      expect(subject.lost?('X')).to eq false
      expect(subject.lost?('O')).to eq true
    end
  end

  describe '#tied?' do
    it 'returns a boolean value describing whether or not the game is tied, ie. the board is full of player symbols but there is no winner' do
      expect(subject.tied?).to eq false
      subject.tiles.map!.with_index { |tile, index| index.even? ? tile = subject.symbols[0] : tile = subject.symbols[1] }
      subject.tiles[6] = 'O'
      subject.tiles[7] = 'X'
      subject.tiles[8] = 'O'
      expect(subject.tied?).to eq true
    end
  end

  describe '#over?' do
    it 'returns a boolean value depending on whether or not describing whether or not the game is over, ie. either won or tied' do
      expect(subject.over?).to eq false
      subject.tiles[2] = 'O'
      subject.tiles[4] = 'O'
      subject.tiles[6] = 'O'
      expect(subject.tied?).to eq false
      expect(subject.won?).to eq true
      expect(subject.over?).to eq true
      subject.reset(2)
      subject.reset(4)
      subject.reset(6)
      expect(subject.over?).to eq false
      subject.tiles.map!.with_index { |tile, index| index.even? ? tile = subject.symbols[0] : tile = subject.symbols[1] }
      subject.tiles[6] = 'O'
      subject.tiles[7] = 'X'
      subject.tiles[8] = 'O'
      expect(subject.tied?).to eq true
      expect(subject.won?).to eq false
      expect(subject.over?).to eq true
    end
  end

  describe '#corners' do
    it 'calculates the corner tiles of the board, based on the boards specified width, and returns an array of them' do
      expect(subject.corners).to eq [0, 2, 6, 8]
      large_board = Board.new(4)
      expect(large_board.corners).to eq [0, 3, 12, 15]
    end
  end

  describe '#winning_horizontals' do # it calculates the winning horizonal rows from the board width
    context 'the board is 3 tiles wide' do
      it 'returns an array containing the index sets of all winning horizontal rows, ie. [[0,1,2],[3,4,5],[6,7,8]]' do
        expect(subject.winning_horizontals).to eq [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
      end
    end
    context 'the board is 4 tiles wide' do
      it 'returns an array containing the index sets of all winning horizontal rows, ie. [[0, 1, 2, 3],[4, 5, 6, 7],[8, 9, 10, 11], [12, 13, 14, 15]' do
        large_board = Board.new(4)
        expect(large_board.winning_horizontals).to eq [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]]
      end
    end
  end

  describe '#winning_verticals' do # it calculates the winning vertical columns from the board width
    context 'the board is 3 tiles wide' do
      it 'returns an array containing the index sets of all winning vertical columns, ie. [[0, 3, 6], [1, 4, 7], [2, 5, 8]]' do
        expect(subject.winning_verticals).to eq [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
      end
    end
    context 'the board is 4 tiles wide' do
      it 'returns an array containing the index sets of all winning vertical columns, ie. [[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]]' do
        large_board = Board.new(4)
        expect(large_board.winning_verticals).to eq [[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]]
      end
    end
  end

  describe '#winning_diagonals' do # it calculates the winning diagonal rows from the board width
    context 'the board is 3 tiles wide' do
      it 'returns an array containing the index sets of all winning diagonal rows, ie. [[0, 4, 8], [2, 4, 6]]' do
        expect(subject.winning_diagonals).to eq [[0, 4, 8], [2, 4, 6]]
      end
    end
    context 'the board is 4 tiles wide' do
      it 'returns an array containing the index sets of all winning diagonal rows, ie. [[0, 5, 10, 15], [3, 6, 9, 12]]' do
        large_board = Board.new(4)
        expect(large_board.winning_diagonals).to eq [[0, 5, 10, 15], [3, 6, 9, 12]]
      end
    end
  end

  describe '#winning_indices' do # it returns all the winning rows and columns from the board width
    context 'the board is 3 tiles wide' do
      it 'returns an array containing the all sets of winning indices' do
        expect(subject.winning_indices).to eq [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
      end
    end
    context 'the board is 4 tiles wide' do
      it 'returns an array containing the all sets of winning indices' do
        large_board = Board.new(4)
        expect(large_board.winning_indices).to eq [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [0, 5, 10, 15], [3, 6, 9, 12]]
      end
    end
  end

  describe '#winning_set' do
    context 'there is currently no winner' do
      it 'returns nil' do
        expect(subject.winning_set).to eq nil
      end
    end
    context 'the game has been won' do
      it 'returns the indices of the set used to win the game' do
        subject.tiles[0] = 'X'
        subject.tiles[1] = 'X'
        subject.tiles[2] = 'X'
        expect(subject.winning_set).to eq [0, 1, 2]
      end
    end
  end
end
