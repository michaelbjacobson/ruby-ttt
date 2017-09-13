require_relative './player.rb'

# This is the human player
class Human < Player

  def choose_move(board)
    gets.chomp
  end

end