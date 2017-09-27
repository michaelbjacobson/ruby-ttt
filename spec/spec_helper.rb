require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start

require_relative '../lib/board.rb'
require_relative '../lib/colouriser.rb'
require_relative '../lib/computer.rb'
require_relative '../lib/game.rb'
require_relative '../lib/human.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ui.rb'

RSpec.configure do |c|
  # Comment out the line directly below this one to include integration tests when running RSpec
  # c.filter_run_excluding slow: true
end
