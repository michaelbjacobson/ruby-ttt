def display
  @counter = 0
  display = Array.new((width + (width - 1)), '')
  display.each_index do |index|
    if index.even?
      line = " #{tile(@counter)} "
      @counter += 1
      (width - 1).times do
        line << "| #{tile(@counter)} "
        @counter += 1
      end
      display[index] = line
    elsif index.odd?
      line = '---'
      (width - 1).times do
        line << '+---'
      end
      display[index] = line
    end
  end
  puts ''
  puts display
  puts ''
end