describe 'gameplay' do

  let(:output) { StringIO.new }

  def setup_test_run(input_string)
    input = StringIO.new(input_string)
    Game.play(input: input, output: output)
  end

  context 'play game' do
    it 'welcomes the player' do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include "Let's play Tic-Tac-Toe!"
    end

    it 'asks the player to select the game type' do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include 'Please select which game type you would like to play...'
      expect(output.string).to include "1 - Human (that's you) vs. The Unbeatable Tic-Tac-Toe Computer."
      expect(output.string).to include '2 - Human (you) vs. Another Human (maybe you, probably not though).'
      expect(output.string).to include '3 - The Unbeatable Tic-Tac-Toe Computer vs... itself.'
    end

    it "asks the player whether they'd like to play as 'X' or 'O'" do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include 'Which symbol would you like to play with? X or O?'
    end

    it "asks the player whether or not they'd like to go first" do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include 'Would you like to go first? (Y)es or (N)o?'
    end

    it "asks the player whether they'd like to play on a standard (3x3) or large (4x4) game board" do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include 'Would you like to play on a (S)tandard board or a (L)arge one?'
    end

    it 'displays the empty game board' do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include "\n 0 | 1 | 2 \n---+---+---\n 3 | 4 | 5 \n---+---+---\n 6 | 7 | 8 \n"
    end

    it "informs the user that it's their turn" do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include "Player 'X', you're up!"
    end

    it 'displays the game board after the user plays their move. Tiles occupied with player symbols are wrapped in code to colour them cyan' do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include "\n 0 | 1 | 2 \n---+---+---\n 3 | 4 | 5 \n---+---+---\n 6 | 7 | \e[36mX\e[0m \n"
    end

    it "informs the user that the computer is taking it's turn" do
      setup_test_run("1\nx\ny\ns\n8\n0\n2\n")
      expect(output.string).to include "Computer 'O' is taking it's turn..."
    end

    it 'informs the user if their choice is invalid' do
      setup_test_run("1\nx\ny\ns\n10\n8\n0\n2\n")
      expect(output.string).to include 'Please enter a number between 0 and 8.'
    end

    it 'informs the user if their chosen tile is already occupied' do
      setup_test_run("1\nx\ny\ns\n8\n8\n0\n2\n")
      expect(output.string).to include 'The tile you selected is not available. Please make another move!'
    end

    it 'informs the user if the game is tied' do
      setup_test_run("3\ns\n")
      expect(output.string).to include 'Tie game!'
    end

    it 'informs the user if the game is won' do
      setup_test_run("1\nx\ny\ns\n8\n8\n0\n2\n")
      expect(output.string).to include 'O wins!'
    end
  end
end