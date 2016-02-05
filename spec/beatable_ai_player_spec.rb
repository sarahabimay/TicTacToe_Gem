require "tictactoe/beatable_ai_player"

RSpec.describe TicTacToe::BeatableAIPlayer do
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:board) { TicTacToe::Board.new(dimension) }
  let(:display_double) { double("UserInterface").as_null_object }
  let(:beatable_player) { TicTacToe::BeatableAIPlayer.new(TicTacToe::Mark::X, display_double) }

  it "knows who it's opponent is" do
    expect(beatable_player.get_opponent_mark).to eq(TicTacToe::Mark::O)
  end

  it "gets next position from ui" do
    allow(beatable_player).to receive(:randomized_move).and_return(5)
    allow(display_double).to receive(:announce_player_move).with(TicTacToe::Mark::X, 5)
    expect(beatable_player.get_next_move(board)).to be_between(1, 9).inclusive 
  end

  it "displays new move to UI" do
    allow(beatable_player).to receive(:randomized_move).and_return(5)
    allow(display_double).to receive(:announce_player_move).with(TicTacToe::Mark::X, 5)
    beatable_player.get_next_move(TicTacToe::Board.new(dimension))
  end
end

