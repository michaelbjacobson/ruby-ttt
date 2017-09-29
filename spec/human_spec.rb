describe Human, fast: true do

  it 'inherits from the Player superclass' do
    expect(subject).to respond_to(:ai?, :symbol)
  end
end
