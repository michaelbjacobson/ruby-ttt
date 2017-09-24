require_relative './player.rb'

# This is the human player
class Human < Player

  def choose_move(board)
    @ui.in
  end

end