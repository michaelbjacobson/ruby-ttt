require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start

require_relative '../lib/config.rb'
require_relative '../lib/board.rb'
require_relative '../lib/colouriser.rb'
require_relative '../lib/computer.rb'
require_relative '../lib/game.rb'
require_relative '../lib/human.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ui.rb'

RSpec.configure do |c|
  Config.set
  if ENV['INTEGRATION_TESTS'] =~ /disabled/i
    c.filter_run_excluding slow: true
  elsif ENV['INTEGRATION_TESTS'] =~ /enabled/i
    break
  end
end

RSpec.configure do |c|
  if ENV['UNIT_TESTS'] =~ /disabled/i
    c.filter_run_excluding fast: true
  elsif ENV['UNIT_TESTS'] =~ /enabled/i
    break
  end
end
