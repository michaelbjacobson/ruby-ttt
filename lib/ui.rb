class UI
  def send(message, output: $stdout)
    output.puts message
  end

  def receive(input: $stdin)
    input.gets.chomp
  end
end
