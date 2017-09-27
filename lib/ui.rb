class UI
  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def out(message, output_stream: @output)
    output_stream.puts message
  end

  def in(input_stream: @input)
    input_stream.gets.chomp
  end
end
