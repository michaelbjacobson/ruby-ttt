describe '3x3 grid AI behaviour', long: true do

  describe 'horizontal blocking' do
    context "AI's opponent has it's symbols in tiles 0 and 1" do
      it "blocks it's opponent at index 2, preventing a winning horizontal" do
        board = Board.new
        board.tiles[0] = 'X'
        board.tiles[4] = 'O'
        board.tiles[1] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '2'
      end
    end

    context "AI's opponent has it's symbols in tiles 3 and 4" do
      it "blocks it's opponent at index 5, preventing a winning horizontal" do
        board = Board.new
        board.tiles[3] = 'X'
        board.tiles[0] = 'O'
        board.tiles[4] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end

    context "AI's opponent has it's symbols in tiles 7 and 8" do
      it "blocks it's opponent at index 6, preventing a winning horizontal" do
        board = Board.new
        board.tiles[8] = 'X'
        board.tiles[4] = 'O'
        board.tiles[7] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '6'
      end
    end
  end

  describe 'vertical blocking' do
    context "AI's opponent has it's symbols in tiles 0 and 3" do
      it "blocks it's opponent at index 6, preventing a winning vertical" do
        board = Board.new
        board.tiles[0] = 'X'
        board.tiles[4] = 'O'
        board.tiles[3] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '6'
      end
    end

    context "AI's opponent has it's symbols in tiles 1 and 4" do
      it "blocks it's opponent at index 7, preventing a winning vertical" do
        board = Board.new
        board.tiles[1] = 'X'
        board.tiles[0] = 'O'
        board.tiles[4] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '7'
      end
    end

    context "AI's opponent has it's symbols in tiles 8 and 5" do
      it "blocks it's opponent at index 2, preventing a winning vertical" do
        board = Board.new
        board.tiles[8] = 'X'
        board.tiles[4] = 'O'
        board.tiles[5] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '2'
      end
    end
  end

  describe 'diagonal blocking' do
    context "AI's opponent has it's symbols in tiles 2 and 4" do
      it "blocks it's opponent at index 6, preventing a winning diagonal" do
        board = Board.new
        board.tiles[4] = 'X'
        board.tiles[0] = 'O'
        board.tiles[2] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '6'
      end
    end

    context "AI's opponent has it's symbols in tiles 0 and 8" do
      it "blocks it's opponent at index 4, preventing a winning diagonal" do
        board = Board.new
        board.tiles[0] = 'X'
        board.tiles[2] = 'O'
        board.tiles[8] = 'X'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '4'
      end
    end
  end

  describe 'horizontal attacking' do
    context "AI has it's symbols in tiles 1 and 2" do
      it 'secures a winning horizontal by playing to index 0' do
        board = Board.new
        board.tiles[1] = 'O'
        board.tiles[7] = 'X'
        board.tiles[2] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '0'
      end
    end

    context "AI has it's symbols in tiles 3 and 4" do
      it 'secures a winning horizontal by playing to index 5' do
        board = Board.new
        board.tiles[3] = 'O'
        board.tiles[8] = 'X'
        board.tiles[4] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end

    context "AI has it's symbols in tiles 6 and 8" do
      it 'secures a winning horizontal by playing to index 7' do
        board = Board.new
        board.tiles[6] = 'O'
        board.tiles[0] = 'X'
        board.tiles[8] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '7'
      end
    end
  end

  describe 'vertical attacking' do
    context "AI has it's symbols in tiles 0 and 3" do
      it 'secures a winning vertical by playing to index 6' do
        board = Board.new
        board.tiles[0] = 'O'
        board.tiles[5] = 'X'
        board.tiles[3] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '6'
      end
    end

    context "AI has it's symbols in tiles 4 and 7" do
      it 'secures a winning vertical by playing to index 1' do
        board = Board.new
        board.tiles[4] = 'O'
        board.tiles[6] = 'X'
        board.tiles[7] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '1'
      end
    end

    context "AI has it's symbols in tiles 2 and 8" do
      it 'secures a winning vertical by playing to index 5' do
        board = Board.new
        board.tiles[2] = 'O'
        board.tiles[3] = 'X'
        board.tiles[8] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '5'
      end
    end
  end

  describe 'diagonal attacking' do
    context "AI has it's symbols in tiles 0 and 4" do
      it 'secures a winning diagonal by playing to index 8' do
        board = Board.new
        board.tiles[0] = 'O'
        board.tiles[6] = 'X'
        board.tiles[4] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '8'
      end
    end

    context "AI has it's symbols in tiles 6 and 2" do
      it 'secures a winning diagonal by playing to index 4' do
        board = Board.new
        board.tiles[6] = 'O'
        board.tiles[0] = 'X'
        board.tiles[2] = 'O'
        ai = Computer.new
        ai.symbol = 'O'
        expect(ai.choose_move(board)).to eq '4'
      end
    end
  end
end