require_relative './board.rb'
require_relative './computer.rb'
require_relative './human.rb'
require_relative './command_line_interface.rb'

# This is the game engine
class Game
  attr_accessor :players, :board

  def initialize(interface)
    @interface = interface
  end

  def self.play
    game = Game.new(Interface.new)
    game.setup
    game.start
  end

  def setup
    settings = @interface.setup
    @players = settings[:players]
    @board = Board.new(settings[:board_size])
    @board.symbols = [@players.first.symbol, @players.last.symbol]
  end

  def start
    until @board.over?
      @interface.display(@board)
      @interface.print_player_message(active_player)
      active_player.make_move(@board)
      switch_turns unless @board.won?
    end
    @interface.display(@board)
    @interface.game_over_message(active_player)
  end

  private

  def active_player
    @players.first
  end

  def switch_turns
    @players.rotate!
  end

end

Game.play if $PROGRAM_NAME == __FILE__
