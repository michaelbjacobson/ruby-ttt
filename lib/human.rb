require_relative './player.rb'

# This is the human player
class Human < Player
  def make_move(board)
    choice = $stdin.gets
    if board.available_tiles.include?(choice.chomp.to_i)
      board.update(choice.chomp.to_i)
    else
      puts 'The tile you selected is not available. Please make another move!'
      make_move(board)
    end
  end
end