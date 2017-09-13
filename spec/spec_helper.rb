require 'simplecov'
require 'simplecov-console'

require_relative '../lib/board.rb'
require_relative '../lib/colouriser.rb'
require_relative '../lib/computer.rb'
require_relative '../lib/game.rb'
require_relative '../lib/human.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ui.rb'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start
