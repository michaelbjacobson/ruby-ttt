require_relative './board.rb'
require_relative './colouriser.rb'
require_relative './computer.rb'
require_relative './human.rb'
require_relative './ui.rb'
require 'benchmark'

# This is the command line interface for the game
class Game
  attr_accessor :players, :board

  INDEX_OFFSET = 1

  def initialize(input, output)
    @ui = UI.new(input, output)
  end

  def self.play(input: $stdin, output: $stdout)
    game = Game.new(input, output)
    game.setup
    game.start
    game
  end

  def setup
    clear_display
    @ui.out("\nLet's play Tic-Tac-Toe!\n\n")
    @players = choose_game_type
    players_are_both_computers? ? assign_symbols_to_computers : select_player_symbols
    select_first_player unless players_are_both_computers?
    @board = Board.new(board_size)
    @board.symbols = [@players.first.symbol, @players.last.symbol]
  end

  def start
    clear_display
    until @board.over?
      display(@board)
      @ui.out(player_message)
      make_move
      switch_turns unless @board.won?
      clear_display
    end
    display(@board)
    @ui.out(game_over_message)
  end

  private

  def board_size
    @ui.out("\nWould you like to play on a (S)tandard board or a (L)arge one?")
    choice = @ui.in
    if choice =~ /\b(s|standard)\b/i
      3
    elsif choice =~ /\b(l|large)\b/i
      4
    else
      @ui.out("Please enter 's' (standard), or 'l' (large)...")
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
    @ui.out(game_types)
    choice = @ui.in
    return [Human.new, Computer.new] if choice == '1'
    return [Human.new, Human.new] if choice == '2'
    return [Computer.new, Computer.new] if choice == '3'
    choose_game_type
  end

  def valid_choice?(tile)
    tile.to_i >= 0 && tile.to_i < (@board.width * @board.width)
  end

  def tile_is_free?(tile)
    @board.tiles[tile.to_i] !~ /[xo]/i
  end

  def print_invalid_choice_message(choice)
    if valid_choice?(choice)
      @ui.out("\nThe tile you selected is not available. Please make another move!")
    else
      @ui.out("\nPlease enter a number between 1 and #{(@board.width * @board.width)}.")
    end
  end

  def make_move
    start_time = Time.now
    choice = active_player.choose_move(@board, @ui)
    end_time = Time.now
    if valid_choice?(adjust(choice)) && tile_is_free?(adjust(choice))
      add_interval(delta(end_time, start_time))
      @board.update(adjust(choice))
    else
      print_invalid_choice_message(adjust(choice))
      make_move
    end
  end

  def delta(start_time, end_time)
    end_time - start_time
  end

  def adjust(choice)
    active_player.ai? ? choice : (choice.to_i - INDEX_OFFSET).to_s
  end

  def add_interval(delta)
    duration = 3
    return unless active_player.ai? && $PROGRAM_NAME == __FILE__
    sleep(delta > duration ? 0 : duration - delta)
  end

  def active_player
    @players.first
  end

  def switch_turns
    @players.rotate!
  end

  def select_player_symbols
    @ui.out("\nWhich symbol would you like to play with? X or O?")
    choice = @ui.in
    if choice =~ /[xo]/i
      @players.first.symbol = choice.upcase
      @players.last.symbol = 'XO'.delete!(choice.upcase)
    else
      @ui.out("Please enter either 'X' or 'O'...")
      select_player_symbols
    end
  end

  def select_first_player
    @ui.out("\nWould you like to go first? (Y)es or (N)o?")
    choice = @ui.in
    return if choice =~ /\b(y|yes)\b/i
    if choice =~ /\b(n|no)\b/i
      switch_turns
    else
      @ui.out("Please enter 'y' (yes), or 'n' (no)...")
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
    @ui.out("\n")
    @display.each { |line| @ui.out(line) }
    @ui.out("\n")
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
    line = "#{tile(@counter)} "
    @counter += 1
    (@board.width - 1).times do
      line << "|#{tile(@counter)} "
      @counter += 1
    end
    @display[index] = line
  end

  def odd(index)
    line = @board.width == 3 ? '---' : '----'
    (@board.width - 1).times do
      line << '+---' if @board.width == 3
      line << '+----' if @board.width != 3
    end
    @display[index] = line
  end

  def tile(index)
    tile = @board.tiles[index] =~ /[XO]/ ? @board.tiles[index].to_s : (index + 1).to_s
    coloured_tile = colour_tile(tile, index)
    add_spaces_to_tile(coloured_tile)
  end

  def colour_tile(tile, index)
    if @board.won? && @board.winning_set.include?(index)
      tile.red
    elsif tile =~ /[xo]/i
      tile.cyan
    else
      tile
    end
  end

  def add_spaces_to_tile(tile)
    if @board.width == 3
      " #{tile}"
    elsif @board.width == 4
      tile.length > 1 ? " #{tile}" : "  #{tile}"
    end
  end

  def clear_display
    system 'clear' if $PROGRAM_NAME == __FILE__ && ENV['TERM']
  end

end

Game.play if $PROGRAM_NAME == __FILE__
