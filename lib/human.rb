require_relative './player.rb'

# This is the human player
class Human < Player

  def choose_move(board, ui)
    ui.in
  end
end
