describe UI do

  describe '#out' do
    it 'is given a string as a argument and displays it via the specified output stream, which is $stdout by default' do
      test_output = StringIO.new
      subject.out('test string', output_stream: test_output)
      expect(test_output.string).to match /test string/
    end
  end

  describe '#in' do
    it 'receives, and then returns, a string from the specified input stream, which is $stdin by default' do
      test_input = StringIO.new('test string')
      expect(subject.in(input_stream: test_input)).to match /test string/
    end
  end

end
