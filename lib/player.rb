require_relative './ui.rb'

# This is the player superclass
# Both Computer and Human inherit from this class
class Player
  attr_accessor :symbol

  def initialize
    @symbol = nil
    # @ui = UI.new
  end

  def ai?
    false
  end
end