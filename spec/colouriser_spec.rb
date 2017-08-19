describe String do

  describe '#red' do
    it "returns a red formatted version of it's String object" do
      expect('Hello, World!'.red).to eq "\e[31mHello, World!\e[0m"
    end
  end

end