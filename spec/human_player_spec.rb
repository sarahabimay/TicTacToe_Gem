require "tictactoe/human_player"
require "stringio"
require "tictactoe/board_options"

RSpec.describe TicTacToe::HumanPlayer do
  let(:display_double) { double("UserInterface").as_null_object }
  let(:human) { TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display_double) }

  it "knows who it's opponent is" do
    expect(human.get_opponent_mark).to eq(TicTacToe::Mark::O)
  end

  it "gets next position from UI" do
    expect(display_double).to receive(:ask_player_for_move).and_return("1")
    expect(human.get_next_move(TicTacToe::Board.new(TicTacToe::BoardOptions::THREE_BY_THREE))).to eq("1")
  end
end
