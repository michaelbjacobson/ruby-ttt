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
    file_contents = File.read(path).strip
    settings = Hash[file_contents.split("\n").map { |line| line.split('=') if line.include? '=' }]
    ENV['UNIT_TESTS'] = settings['unit_tests'] =~ /(enabled|disabled)/i ? settings['unit_tests'].downcase : 'enabled'
    ENV['INTEGRATION_TESTS'] = settings['integration_tests'] =~ /(enabled|disabled)/i ? settings['integration_tests'].downcase : 'enabled'
    ENV['COMPUTER_MOVE_DELAY'] = settings['computer_move_delay'].to_i > 0 ? settings['computer_move_delay'] : '2'
    ENV['COMPUTER_EVALUATION_DEPTH'] = settings['computer_evaluation_depth'].to_i > 0 ? settings['computer_evaluation_depth'] : '5'
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