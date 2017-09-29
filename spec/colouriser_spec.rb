describe String, fast: true do

  it 'has new methods: #red and #cyan' do
    expect(subject).to respond_to(:red)
    expect(subject).to respond_to(:cyan)
  end

  describe '#red' do
    it 'wraps the string in code to color it red in a Unix terminal' do
      expect('Hello, World!'.red).to eq "\e[31mHello, World!\e[0m"
    end
  end

  describe '#cyan' do
    it 'wraps the string in code to color it cyan in a Unix terminal' do
      expect('Hello, World!'.cyan).to eq "\e[36mHello, World!\e[0m"
    end
  end
end