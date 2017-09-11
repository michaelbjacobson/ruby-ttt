class UI
  def out(message, output: $stdout)
    output.puts message
  end

  def in(input: $stdin)
    input.gets.chomp
  end
end
