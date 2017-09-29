require 'find'

# This configures the game, either from a file or from default settings
class Config

  def self.set
    if File.file?('../config') || File.file?('./config')
      from_file(config_file_path)
    else
      defaults
    end
  end

  def self.from_file(path)
    settings = Hash[File.read(path).split("\n").map { |l| l.split('=') } ]
    ENV['UNIT_TESTS'] = settings['unit_tests']
    ENV['INTEGRATION_TESTS'] = settings['integration_tests']
    ENV['COMPUTER_MOVE_DELAY'] = settings['computer_move_delay']
    ENV['COMPUTER_EVALUATION_DEPTH'] = settings['computer_evaluation_depth']
  end

  def self.defaults
    ENV['UNIT_TESTS'] = 'enabled'
    ENV['INTEGRATION_TESTS'] = 'enabled'
    ENV['COMPUTER_MOVE_DELAY'] = '2'
    ENV['COMPUTER_EVALUATION_DEPTH'] = '5'
  end

  def self.config_file_path
    return './config' if File.file?('./config') # for RSpec
    return '../config' if File.file?('../config') # for Game
  end
end