require_relative './board.rb'
require_relative './computer.rb'
require_relative './human.rb'

# This is the game engine
class Game
  attr_accessor :players, :board

  def self.play
    puts "\nLet's play Tic-Tac-Toe!\n\n"
    game = new
    game.setup
    game.start
    game
  end

  def setup
    @players = choose_game_type
    @board = Board.new(board_size)
    players_are_both_computers? ? assign_symbols_to_computers : select_player_symbols
    select_first_player unless players_are_both_computers?
    @board.symbols = [@players.first.symbol, @players.last.symbol]
  end

  def start
    until @board.over?
      @board.display
      puts player_message
      active_player.make_move(@board)
      switch_turns unless @board.won?
    end
    @board.display
    puts game_over_message
  end

  private

  def board_size
    puts "\nWould you like to play on a (S)tandard board or a (L)arge one?"
    choice = $stdin.gets
    if choice.chomp =~ /\b(s|standard)\b/i
      3
    elsif choice.chomp =~ /\b(l|large)\b/i
      4
    else
      puts "Please enter 's' (standard), or 'l' (large)..."
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
    puts game_types
    choice = $stdin.gets
    choice.chomp!
    return [Human.new, Computer.new] if choice == '1'
    return [Human.new, Human.new] if choice == '2'
    return [Computer.new, Computer.new] if choice == '3'
    choose_game_type
  end

  def active_player
    @players.first
  end

  def switch_turns
    @players.rotate!
  end

  def select_player_symbols
    puts "\nWhich symbol would you like to play with? X or O?"
    choice = $stdin.gets
    if choice.chomp =~ /[xo]/i
      @players.first.symbol = choice.chomp.upcase
      @players.last.symbol = 'XO'.delete!(choice.upcase)
    else
      puts "Please enter either 'X' or 'O'..."
      select_player_symbols
    end
  end

  def select_first_player
    puts "\nWould you like to go first? (Y)es or (N)o?"
    choice = $stdin.gets
    return if choice.chomp =~ /\b(y|yes)\b/i
    if choice.chomp =~ /\b(n|no)\b/i
      @board.symbols.rotate!
      switch_turns
    else
      puts "Please enter 'y' (yes), or 'n' (no)..."
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
end

Game.play if $PROGRAM_NAME == __FILE__
