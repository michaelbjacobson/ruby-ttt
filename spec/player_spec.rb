describe Player do
  it 'can be initialised and given a symbol' do
    player = Player.new
    player.symbol = 'X'
    expect(player.symbol).to eq 'X'
  end
end
