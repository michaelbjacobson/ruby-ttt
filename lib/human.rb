require_relative './player.rb'

# This is the human player
class Human < Player

  def choose_move(board = nil, input: $stdin)
    @ui.in(input_stream: input)
  end

end