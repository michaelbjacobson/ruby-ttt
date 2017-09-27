class UI
  def out(message, output_stream: $stdout)
    output_stream.puts message
  end

  def in(input_stream: $stdin)
    input_stream.gets.chomp
  end
end
