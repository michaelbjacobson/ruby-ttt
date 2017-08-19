require_relative './player.rb'

# This is the unbeatable computer player
class Computer < Player
  attr_reader :symbol

  MINIMUM_DEPTH = 0
  MAXIMUM_DEPTH = 6
  MAXIMUM_SCORE = 1000

  def ai?
    true
  end

  def make_move(board)
    board.update(choose_move(board))
  end

  private

  def choose_move(board)
    return opening_gambit(board) if board.empty?
    select_best_space(board)
  end

  def heuristic_value(board, depth)
    return MAXIMUM_SCORE / depth if board.won?(symbol)
    return -MAXIMUM_SCORE / depth if board.lost?(symbol)
    0
  end

  def negamax(board, depth = MINIMUM_DEPTH, alpha = -MAXIMUM_SCORE, beta = MAXIMUM_SCORE, color = 1, max_depth = MAXIMUM_DEPTH)
    return color * heuristic_value(board, depth) if board.over? || depth > max_depth

    max = -MAXIMUM_SCORE

    board.available_tiles.each do |space|
      board.update(space)
      negamax_value = -negamax(board, depth + 1, -beta, -alpha, -color)
      board.reset(space)
      max = [max, negamax_value].max
      @best_score[space] = max if depth == MINIMUM_DEPTH
      alpha = [alpha, negamax_value].max
      return alpha if alpha >= beta
    end

    max
  end

  def opening_gambit(board)
    board.corners.sample
  end

  def select_best_space(board)
    @best_score = {}
    negamax(board)
    @best_score.max_by { |key, value| value }[0]
  end

end
