require './colouriser.rb'
require './human.rb'
require './computer.rb'
require './board.rb'

# Command Line Interface
class Interface

  def print_greeting
    puts "\nLet's play Tic-Tac-Toe!\n\n"
  end

  def setup
    print_greeting
    @players = choose_game_type
    players_are_both_computers? ? assign_computer_symbols : select_player_symbol
    select_first_player unless players_are_both_computers?
    { players: @players, board_size: board_size }
  end

  def display(board)
    @board = board
    build_display
    puts "\n"
    @display.each { |line| puts line }
    puts "\n"
  end

  def game_over_message(player)
    winner = "#{player.symbol} wins!\n"
    tie = "Tie game!\n"
    puts @board.won? ? winner : tie
  end

  def print_player_message(player)
    computer_message = "Computer '#{player.symbol}' is taking it's turn..."
    human_message = "Player '#{player.symbol}', you're up!"
    puts player.ai? ? computer_message : human_message
  end

  private

  def players_are_both_computers?
    @players.first.ai? && @players.last.ai?
  end

  def assign_computer_symbols
    return unless players_are_both_computers?
    symbols = %w[X O].shuffle!
    @players.first.symbol = symbols.pop
    @players.last.symbol = symbols.pop
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
    tile = @board.tiles[index]
    @board.won? && @board.winning_set.include?(index) ? tile.red : tile
  end

  def select_player_symbol
    puts "\nWhich symbol would you like to play with? X or O?"
    choice = gets
    if choice.chomp =~ /[xo]/i
      @players.first.symbol = choice.chomp.upcase
      @players.last.symbol = 'XO'.delete!(choice.upcase)
    else
      puts "Please enter either 'X' or 'O'..."
      select_player_symbol
    end
  end

  def select_first_player
    puts "\nWould you like to go first? (Y)es or (N)o?"
    choice = gets
    return if choice.chomp =~ /\b(y|yes)\b/i
    if choice.chomp =~ /\b(n|no)\b/i
      @players.rotate!
    else
      puts "Please enter 'y' (yes), or 'n' (no)..."
      select_first_player
    end
  end

  def board_size
    puts "\nWould you like to play on a (S)tandard board or a (L)arge one?"
    choice = gets
    if choice.chomp =~ /\b(s|standard)\b/i
      3
    elsif choice.chomp =~ /\b(l|large)\b/i
      4
    else
      puts "Please enter 's' (standard), or 'l' (large)..."
      board_size
    end
  end

  def print_game_types
    puts "Please select which game type you would like to play...\n" \
         "1 - Human (that's you) vs. The Unbeatable Tic-Tac-Toe Computer.\n" \
         "2 - Human (you) vs. Another Human (maybe you, probably not though).\n" \
         "3 - The Unbeatable Tic-Tac-Toe Computer vs... itself.\n"
  end

  def choose_game_type
    print_game_types
    choice = gets
    choice.chomp!
    return [Human.new, Computer.new] if choice == '1'
    return [Human.new, Human.new] if choice == '2'
    return [Computer.new, Computer.new] if choice == '3'
    choose_game_type
  end

end