require_relative './player.rb'

# This is the human player
class Human < Player
  def move(board)
    choice = gets
    choice.chomp.to_i
  end
end