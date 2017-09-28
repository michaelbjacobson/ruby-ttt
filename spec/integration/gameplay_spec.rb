describe 'gameplay', slow: true do

  let(:output) { StringIO.new }

  def setup_test_run(input_string)
    input = StringIO.new(input_string)
    Game.play(input: input, output: output)
  end

  describe 'play game' do
    it 'welcomes the player' do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include "Let's play Tic-Tac-Toe!"
    end

    it 'asks the player to select the game type' do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include 'Please select which game type you would like to play...'
      expect(output.string).to include "1 - Human (that's you) vs. The Unbeatable Tic-Tac-Toe Computer."
      expect(output.string).to include '2 - Human (you) vs. Another Human (maybe you, probably not though).'
      expect(output.string).to include '3 - The Unbeatable Tic-Tac-Toe Computer vs... itself.'
    end

    it 're-prompts the player to select a valid game type if an invalid selection is made' do
      setup_test_run("0\n1\nx\ny\ns\n9\n1\n3\n")
      count = output.string.scan(/Please select which game type you would like to play/).size
      expect(output.string).to include 'Please select which game type you would like to play'
      expect(count).to eq 2
    end

    it "asks the player whether they'd like to play as 'X' or 'O'" do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include 'Which symbol would you like to play with? X or O?'
    end

    it 're-prompts the player to select a valid symbol if an invalid selection is made' do
      setup_test_run("1\nz\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include "Please enter either 'X' or 'O'..."
    end

    it "asks the player whether or not they'd like to go first" do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include 'Would you like to go first? (Y)es or (N)o?'
    end

    it 're-prompts the player to indicate whether or not they want to go first if an invalid selection is made' do
      setup_test_run("1\nx\nz\ny\ns\n9\n1\n3\n")
      expect(output.string).to include "Please enter 'y' (yes), or 'n' (no)..."
    end

    it "asks the player whether they'd like to play on a standard (3x3) or large (4x4) game board" do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include 'Would you like to play on a (S)tandard board or a (L)arge one?'
    end

    it 're-prompts the player to select a valid board size if an invalid selection is made' do
      setup_test_run("1\nx\ny\nz\ns\n9\n1\n3\n")
      expect(output.string).to include "Please enter 's' (standard), or 'l' (large)..."
    end

    it "informs the player when it's their turn" do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include "Player 'X', you're up!"
    end

    it "informs the player when the computer is taking it's turn" do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include "Computer 'O' is taking it's turn..."
    end

    it 'informs the player if their choice is invalid' do
      setup_test_run("1\nx\ny\ns\n10\n9\n1\n3\n")
      expect(output.string).to include 'Please enter a number between 1 and 9.'
    end

    it 'informs the player if their chosen tile is already occupied' do
      setup_test_run("1\nx\ny\ns\n9\n9\n1\n3\n")
      expect(output.string).to include 'The tile you selected is not available. Please make another move!'
    end

    it 'informs the player if the game is tied' do
      setup_test_run("3\ns\n")
      expect(output.string).to include 'Tie game!'
    end

    it 'informs the player if the game is won' do
      setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
      expect(output.string).to include 'O wins!'
    end

    context '3x3 game board' do
      it 'displays the empty game board' do
        setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
        expect(output.string).to include "\n 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 \n"
      end

      it 'displays the game board after the user plays their move. Tiles occupied with player symbols are wrapped in code to colour them cyan' do
        setup_test_run("1\nx\ny\ns\n9\n1\n3\n")
        expect(output.string).to include "\n 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | \e[36mX\e[0m \n"
      end
    end

    context '4x4 game board' do
      it 'displays the empty game board' do
        setup_test_run("1\nx\ny\nl\n16\n8\n9\n13\n")
        expect(output.string).to include "  1 |  2 |  3 |  4 \n----+----+----+----\n  5 |  6 |  7 |  8 \n----+----+----+----\n  9 | 10 | 11 | 12 \n----+----+----+----\n 13 | 14 | 15 | 16 \n"
      end

      it 'displays the game board after the user plays their move. Tiles occupied with player symbols are wrapped in code to colour them cyan' do
        setup_test_run("1\nx\ny\nl\n16\n8\n9\n13\n")
        expect(output.string).to include "  1 |  2 |  3 |  4 \n----+----+----+----\n  5 |  6 |  7 |  8 \n----+----+----+----\n  9 | 10 | 11 | 12 \n----+----+----+----\n 13 | 14 | 15 |  \e[36mX\e[0m \n"
      end
    end
  end
end
