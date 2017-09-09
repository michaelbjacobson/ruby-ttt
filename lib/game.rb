require_relative './board.rb'
require_relative './computer.rb'
require_relative './human.rb'
require_relative './ui.rb'

# This is the command line interface for the game
class Game
  attr_accessor :players, :board

  def initialize
    @ui = UI.new
  end

  def self.play
    game = Game.new
    game.setup
    game.start
    game
  end

  def setup
    @ui.send("\nLet's play Tic-Tac-Toe!\n\n")
    @players = choose_game_type
    players_are_both_computers? ? assign_symbols_to_computers : select_player_symbols
    select_first_player unless players_are_both_computers?
    @board = Board.new(board_size)
    @board.symbols = [@players.first.symbol, @players.last.symbol]
  end

  def start
    until @board.over?
      display(@board)
      @ui.send(player_message)
      make_move
      switch_turns unless @board.won?
    end
    display(@board)
    @ui.send(game_over_message)
  end

  private

  def board_size
    @ui.send("\nWould you like to play on a (S)tandard board or a (L)arge one?")
    choice = @ui.receive
    if choice.chomp =~ /\b(s|standard)\b/i
      3
    elsif choice.chomp =~ /\b(l|large)\b/i
      4
    else
      @ui.send("Please enter 's' (standard), or 'l' (large)...")
      board_size
    end
  end

  def game_over_message
    if @board.won?
      "#{active_player.symbol} wins!\n"
    elsif @board.tied?
      "Tie game!\n"
    end
  end

  def player_message
    return "Computer '#{active_player.symbol}' is taking it's turn..." if active_player.ai?
    "Player '#{active_player.symbol}', you're up!"
  end

  def game_types
    "Please select which game type you would like to play...\n" \
    "1 - Human (that's you) vs. The Unbeatable Tic-Tac-Toe Computer.\n" \
    "2 - Human (you) vs. Another Human (maybe you, probably not though).\n" \
    "3 - The Unbeatable Tic-Tac-Toe Computer vs... itself.\n"
  end

  def choose_game_type
    @ui.send(game_types)
    choice = @ui.receive
    choice.chomp!
    return [Human.new, Computer.new] if choice == '1'
    return [Human.new, Human.new] if choice == '2'
    return [Computer.new, Computer.new] if choice == '3'
    choose_game_type
  end

  def valid_choice?(tile)
    tile.length == 1 && tile =~ /[0-8]/
  end

  def tile_is_free?(tile)
    @board.tiles[tile.to_i] !~ /[xo]/i
  end

  def print_invalid_choice_message
    @ui.send("\nPlease enter a number between 0 and 8.")
  end

  def print_tile_is_not_free
    @ui.send("\nThe tile you selected is not available. Please make another move!")
  end

  def make_move
    choice = active_player.choose_move(@board)
    if valid_choice?(choice) && tile_is_free?(choice)
      @board.update(choice)
    elsif !valid_choice?(choice)
      print_invalid_choice_message
      make_move
    elsif !tile_is_free?(choice)
      print_tile_is_not_free
      make_move
    end
  end

  def active_player
    @players.first
  end

  def switch_turns
    @players.rotate!
  end

  def select_player_symbols
    @ui.send("\nWhich symbol would you like to play with? X or O?")
    choice = @ui.receive
    if choice.chomp =~ /[xo]/i
      @players.first.symbol = choice.chomp.upcase
      @players.last.symbol = 'XO'.delete!(choice.upcase)
    else
      @ui.send("Please enter either 'X' or 'O'...")
      select_player_symbols
    end
  end

  def select_first_player
    @ui.send("\nWould you like to go first? (Y)es or (N)o?")
    choice = @ui.receive
    return if choice.chomp =~ /\b(y|yes)\b/i
    if choice.chomp =~ /\b(n|no)\b/i
      @board.symbols.rotate!
      switch_turns
    else
      @ui.send("Please enter 'y' (yes), or 'n' (no)...")
      select_first_player
    end
  end

  def players_are_both_computers?
    @players.first.ai? && @players.last.ai?
  end

  def assign_symbols_to_computers
    return unless players_are_both_computers?
    symbols = %w[X O].shuffle!
    @players.first.symbol = symbols.pop
    @players.last.symbol = symbols.pop
  end

  def display(board)
    @board = board
    build_display
    @ui.send("\n")
    @display.each { |line| @ui.send(line) }
    @ui.send("\n")
  end

  def build_display
    @counter = 0
    @display = Array.new((@board.width + (@board.width - 1)), '')
    @display.each_index do |index|
      even(index) if index.even?
      odd(index) if index.odd?
    end
  end

  def even(index)
    line = " #{tile(@counter)} "
    @counter += 1
    (@board.width - 1).times do
      line << "| #{tile(@counter)} "
      @counter += 1
    end
    @display[index] = line
  end

  def odd(index)
    line = '---'
    (@board.width - 1).times do
      line << '+---'
    end
    @display[index] = line
  end

  def tile(index)
    tile = @board.tiles[index].to_s
    # @board.won? && @board.winning_set.include?(index) ? tile.red : tile
    if @board.won? && @board.winning_set.include?(index)
      tile.red
    elsif tile =~ /[xo]/i
      tile.cyan
    else
      tile
    end
  end
end

Game.play if $PROGRAM_NAME == __FILE__
