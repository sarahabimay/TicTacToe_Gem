require "tictactoe/mark"

RSpec.describe TicTacToe::Mark do
  it "contains two enums Mark::X" do
    expect(TicTacToe::Mark::X).to eq("X")
  end 
  it "contains enums Mark::O" do
    expect(TicTacToe::Mark::O).to eq("O")
  end 
  it "doesn't contain anything but Mark::X and Mark::O" do
    expect(TicTacToe::Mark.is_a_mark?("BLAH")).to eq(false)
  end
end
