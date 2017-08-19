require 'simplecov'
require 'simplecov-console'

require_relative '../lib/board.rb'
require_relative '../lib/colouriser.rb'
require_relative '../lib/computer.rb'
require_relative '../lib/game.rb'
require_relative '../lib/human.rb'
require_relative '../lib/player.rb'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start

# All tests use a file located at './spec/stdout/output-log.txt' for $stdout
# and $stderr. This makes the output of the tests much cleaner.

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    $stderr = File.new(File.join(File.dirname(__FILE__), 'stdout', 'output-log.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'stdout', 'output-log.txt'), 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end
end
