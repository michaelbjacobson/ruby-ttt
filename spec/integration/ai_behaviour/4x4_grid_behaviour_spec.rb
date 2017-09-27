describe '4x4 grid AI behaviour', long: true do

  describe 'horizontal blocking' do
    context "AI's opponent has it's symbols in tiles 0, 1 and 2" do
      it "blocks it's opponent at index 3, preventing a winning horizontal" do
        board = Board.new(4)
        board.tiles[0] = 'X'
        board.tiles[12] = 'O'
        board.tiles[1] = 'X'
        board.tiles[8] = 'O'
        board.tiles[2] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '3'
      end
    end

    context "AI's opponent has it's symbols in tiles 8, 10 and 11" do
      it "blocks it's opponent at index 9, preventing a winning horizontal" do
        board = Board.new(4)
        board.tiles[8] = 'X'
        board.tiles[0] = 'O'
        board.tiles[10] = 'X'
        board.tiles[1] = 'O'
        board.tiles[11] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '9'
      end
    end
  end

  describe 'vertical blocking' do
    context "AI's opponent has it's symbols in tiles 1, 9 and 13" do
      it "blocks it's opponent at index 5, preventing a winning vertical" do
        board = Board.new(4)
        board.tiles[1] = 'X'
        board.tiles[12] = 'O'
        board.tiles[9] = 'X'
        board.tiles[8] = 'O'
        board.tiles[13] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end

    context "AI's opponent has it's symbols in tiles 7, 11 and 15" do
      it "blocks it's opponent at index 3, preventing a winning vertical" do
        board = Board.new(4)
        board.tiles[7] = 'X'
        board.tiles[12] = 'O'
        board.tiles[11] = 'X'
        board.tiles[9] = 'O'
        board.tiles[15] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '3'
      end
    end
  end

  describe 'diagonal blocking' do
    context "AI's opponent has it's symbols in tiles 0, 10 and 15" do
      it "blocks it's opponent at index 5, preventing a winning diagonal" do
        board = Board.new(4)
        board.tiles[0] = 'X'
        board.tiles[2] = 'O'
        board.tiles[10] = 'X'
        board.tiles[3] = 'O'
        board.tiles[15] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end

    context "AI's opponent has it's symbols in tiles 3, 6 and 9" do
      it "blocks it's opponent at index 12, preventing a winning diagonal" do
        board = Board.new(4)
        board.tiles[3] = 'X'
        board.tiles[10] = 'O'
        board.tiles[6] = 'X'
        board.tiles[11] = 'O'
        board.tiles[9] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '12'
      end
    end
  end

  describe 'horizontal attacking' do
    context "AI has it's symbols in tiles 0, 1 and 2" do
      it 'secures a winning horizontal by playing to index 3' do
        board = Board.new(4)
        board.tiles[0] = 'O'
        board.tiles[12] = 'X'
        board.tiles[1] = 'O'
        board.tiles[8] = 'X'
        board.tiles[2] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '3'
      end
    end

    context "AI has it's symbols in tiles 8, 10 and 11" do
      it 'secures a winning horizontal by playing to index 9' do
        board = Board.new(4)
        board.tiles[8] = 'O'
        board.tiles[0] = 'X'
        board.tiles[10] = 'O'
        board.tiles[1] = 'X'
        board.tiles[11] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '9'
      end
    end
  end

  describe 'vertical attacking' do
    context "AI has it's symbols in tiles 1, 9 and 13" do
      it 'secures a winning vertical by playing to index 5' do
        board = Board.new(4)
        board.tiles[1] = 'O'
        board.tiles[12] = 'X'
        board.tiles[9] = 'O'
        board.tiles[8] = 'X'
        board.tiles[13] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end

    context "AI has it's symbols in tiles 7, 11 and 15" do
      it 'secures a winning vertical by playing to index 3' do
        board = Board.new(4)
        board.tiles[7] = 'O'
        board.tiles[12] = 'X'
        board.tiles[11] = 'O'
        board.tiles[9] = 'X'
        board.tiles[15] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '3'
      end
    end
  end

  describe 'diagonal attacking' do
    context "AI has it's symbols in tiles 0, 10 and 15" do
      it 'secures a winning vertical by playing to index 5' do
        board = Board.new(4)
        board.tiles[0] = 'O'
        board.tiles[2] = 'X'
        board.tiles[10] = 'O'
        board.tiles[3] = 'X'
        board.tiles[15] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end

    context "AI has it's symbols in tiles 3, 6 and 9" do
      it 'secures a winning vertical by playing to index 12' do
        board = Board.new(4)
        board.tiles[3] = 'O'
        board.tiles[10] = 'X'
        board.tiles[6] = 'O'
        board.tiles[11] = 'X'
        board.tiles[9] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '12'
      end
    end
  end
end