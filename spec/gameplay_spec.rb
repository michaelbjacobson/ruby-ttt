describe 'gameplay' do

  def human_move
    %w[0 1 2 3 4 5 6 7 8].sample
  end

  # ***WARNING*** THIS TEST IS VERY TIME CONSUMING (Approx. 90 seconds)
  describe 'computer vs computer' do
    it 'will always result in a tie game' do
      10.times do
        expect($stdin).to receive(:gets).and_return('3')
        game = Game.play
        expect(game.game_over_message).to eq "Tie game!\n"
      end
    end
  end

  # ***WARNING*** THIS TEST IS TIME CONSUMING (Approx. 10 seconds)
  describe 'human vs computer' do
    it 'will always result in a tie game or computer victory' do
      10.times do
        allow($stdin).to receive(:gets).and_return(
          '1', 'X', 'N',
          human_move, human_move, human_move,
          human_move, human_move, human_move,
          human_move, human_move, human_move,
          human_move, human_move, human_move,
          human_move, human_move, human_move,
          human_move, human_move, human_move,
          human_move, human_move, human_move,
          human_move, human_move, human_move
        )
        game = Game.play
        expect(game.game_over_message).to satisfy do |result|
          result == "O wins!\n" || result == "Tie game!\n"
        end
      end
    end
  end

end
