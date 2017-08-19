require_relative './colouriser.rb'

# This is the game board
class Board
  attr_accessor :tiles, :symbols, :width

  def initialize(width = 3)
    @width = width
    @tiles = Array.new((width * width), ' ')
    @symbols = []
  end

  def tile(index)
    won? && winning_set.include?(index) ? @tiles[index].red : @tiles[index]
  end

  def available_tiles
    @tiles.collect.with_index { |tile, index| tile == ' ' ? index : nil }.compact
  end

  def update(tile)
    @tiles[tile.to_i] = active_player_symbol if @tiles[tile.to_i] == ' '
  end

  def reset(tile)
    @tiles[tile.to_i] = ' '
  end

  def over?
    won? || tied?
  end

  def tied?
    full? && !won?
  end

  def winning_set
    return unless won?
    winning_indices.each do |set|
      if set.all? { |index| @tiles[index] == @symbols.first } ||
         set.all? { |index| @tiles[index] == @symbols.last }
        return set
      end
    end
  end

  def lost?(player_symbol)
    opponent_symbol = @symbols.join.delete(player_symbol)
    winning_indices.any? do |set|
      set.all? { |index| @tiles[index] == opponent_symbol }
    end
  end

  def won?(player_symbol = nil)
    if player_symbol.nil?
      winning_indices.any? do |set|
        set.all? { |index| @tiles[index] == @symbols.first } ||
          set.all? { |index| @tiles[index] == @symbols.last }
      end
    else
      winning_indices.any? do |set|
        set.all? { |index| @tiles[index] == player_symbol }
      end
    end
  end

  def empty?
    @tiles.all? { |symbol| symbol == ' ' }
  end

  def full?
    @tiles.all? { |symbol| symbol =~ /[#{@symbols.join}]/ }
  end

  def active_player_symbol
    turn_count.even? ? @symbols.first : @symbols.last
  end

  def turn_count
    @tiles.count { |symbol| symbol =~ /[#{@symbols.join}]/ }
  end

  def corners
    corners = [0]
    corners << width - 1
    corners << width * corners[1]
    corners << corners[2] + corners[1]
    corners
  end

  def winning_horizontals
    horizontals = [[*0...width]]
    (width - 1).times do
      horizontals << horizontals.last.collect { |i| i + width }
    end
    horizontals
  end

  def winning_verticals
    verticals = [(0...(width * width)).step(width).to_a]
    (width - 1).times do
      verticals << verticals.last.collect { |i| i + 1 }
    end
    verticals
  end

  def winning_diagonals
    diagonals = [(0...(width * width)).step(width + 1).to_a]
    diagonals << ((width - 1)..((width * width) - width)).step(width - 1).to_a
    diagonals
  end

  def winning_indices
    winning_indices = []
    winning_horizontals.each { |horizonal| winning_indices << horizonal }
    winning_verticals.each { |vertical| winning_indices << vertical }
    winning_diagonals.each { |diagonal| winning_indices << diagonal }
    winning_indices
  end

end
