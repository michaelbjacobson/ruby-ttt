# This handles output and user input
class UI
  def out(message, output: $stdout)
    output.puts message
  end

  def in(input: $stdin)
    input.gets.chomp
  end
end
