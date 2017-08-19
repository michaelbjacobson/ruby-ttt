describe Game do

  it 'is initialized with an empty @players array by default' do
    expect(subject.players).to eq []
  end

  it "creates it's board object from board_class_object argument" do
    board = double(:board)
    expect(board).to receive(:new)
    Game.new(board)
  end

  describe '#game_types' do
    it 'returns a list of game types and their respective numeric options' do
      expected_output = "Please select which game type you would like to play...\n" \
                        "1 - Human (that's you) vs. The Unbeatable Tic-Tac-Toe Computer.\n" \
                        "2 - Human (you) vs. Another Human (maybe you, probably not though).\n" \
                        "3 - The Unbeatable Tic-Tac-Toe Computer vs... itself.\n"
      expect(subject.game_types).to eq expected_output
    end
  end

  describe '#game_over_message' do
    context 'game has been won' do
      it 'returns a message to say that the game has been won' do
        board_instance = double(:board_instance, won?: true)
        game = Game.new(double(:board_class, new: board_instance))
        game.players = [double(:human, symbol: 'X'), double(:computer, symbol: 'O')]
        expect(game.game_over_message).to eq "X wins!\n"
      end
    end
    context 'game is tied' do
      it 'returns a message to say that the game has been tied' do
        board_instance = double(:board_instance, tied?: true, won?: false)
        game = Game.new(double(:board_class, new: board_instance))
        expect(game.game_over_message).to eq "Tie game!\n"
      end
    end
  end

  describe '#active_payer' do
    it 'returns the active player for the game' do
      player1 = double(:player)
      player2 = double(:player)
      subject.players = [player1, player2]
      expect(subject.players[0]).to eq player1
      expect(subject.active_player).to eq player1
    end
  end

  describe '#switch_turns' do
    it 'changes the active player for the game' do
      player1 = double(:player)
      player2 = double(:player)
      subject.players = [player1, player2]
      expect(subject.active_player).to eq player1
      subject.switch_turns
      expect(subject.active_player).to eq player2
    end
  end

  describe '#player_message' do
    context 'the active player is a computer player' do
      it "informs the user that the computer is taking it's turn" do
        computer = double(:computer, class: Computer, symbol: 'X')
        human = double(:human, class: Human, symbol: 'O')
        subject.players = [computer, human]
        expect(subject.player_message).to eq "Computer 'X' is taking it's turn..."
      end
    end

    context 'the active player is a human player' do
      it 'informs the user that it is their turn' do
        computer = double(:computer, class: Computer, symbol: 'X')
        human = double(:human, class: Human, symbol: 'O')
        subject.players = [human, computer]
        expect(subject.player_message).to eq "Player 'O', you're up!"
      end
    end
  end

  describe '#choose_game_type' do
    it 'receives user selection for game type and returns an array of user objects' do
      human = double(:human)
      computer = double(:computer)
      allow(Human).to receive(:new).and_return(human)
      allow(Computer).to receive(:new).and_return(computer)
      allow($stdin).to receive(:gets).and_return('1', '2', '3')
      expect(subject.choose_game_type).to eq [human, computer]
      expect(subject.choose_game_type).to eq [human, human]
      expect(subject.choose_game_type).to eq [computer, computer]
    end
  end

  describe '#select_player_symbols' do
    context 'user selects X' do
      it 'assigns X to the user player and O to the other player' do
        player1 = double(:player)
        player2 = double(:player)
        allow($stdin).to receive(:gets).and_return('X')
        subject.players = [player1, player2]
        expect(player1).to receive(:symbol=).with('X')
        expect(player2).to receive(:symbol=).with('O')
        subject.select_player_symbols
      end
    end

    context 'user selects O' do
      it 'assigns O to the user player and X to the other player' do
        player1 = double(:player)
        player2 = double(:player)
        allow($stdin).to receive(:gets).and_return('O')
        subject.players = [player1, player2]
        expect(player1).to receive(:symbol=).with('O')
        expect(player2).to receive(:symbol=).with('X')
        subject.select_player_symbols
      end
    end
  end

  describe '#select_first_player' do
    context 'user opts to go first' do
      it 'keeps the user as the active player' do
        player1 = double(:player)
        player2 = double(:player)
        subject.players = [player1, player2]
        allow($stdin).to receive(:gets).and_return('y')
        subject.select_first_player
        expect(subject.active_player).to eq player1
      end
    end

    context 'user opts to go second' do
      it 'keeps makes the second player the active player' do
        player1 = double(:player)
        player2 = double(:player)
        subject.players = [player1, player2]
        allow($stdin).to receive(:gets).and_return('n')
        subject.select_first_player
        expect(subject.active_player).to eq player2
      end
    end
  end

  describe '#assign_symbols_to_computers' do
    it 'randomly assigns two different symbols to computer players' do
      player1 = double(:computer, class: Computer)
      player2 = double(:computer, class: Computer)
      subject.players = [player1, player2]
      expect(player1).to receive(:symbol=).with(/[XO]/)
      expect(player2).to receive(:symbol=).with(/[XO]/)
      subject.assign_symbols_to_computers
    end
  end

  describe '#players_are_both_computers?' do
    context 'both players are instances of the Computer class' do
      it 'returns true' do
        computer = double(:computer, class: Computer)
        subject.players = [computer, computer]
        expect(subject.players_are_both_computers?).to eq true
      end
    end

    context 'one player is an instance of the Computer class' do
      it 'returns false' do
        computer = double(:computer, class: Computer)
        human = double(:computer, class: Human)
        subject.players = [computer, human]
        expect(subject.players_are_both_computers?).to eq false
      end
    end

    context 'both players are instances of the Human class' do
      it 'returns false' do
        human = double(:computer, class: Human)
        subject.players = [human, human]
        expect(subject.players_are_both_computers?).to eq false
      end
    end
  end

end