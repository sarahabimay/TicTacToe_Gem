require "tictactoe/game_type_options"

RSpec.describe TicTacToe::GameTypeOptions do
  HVH_OPTION = "Human Vs Human (1)"
  HVB_OPTION = "Human Vs Easy AI (2)"
  BVH_OPTION = "Easy AI Vs Human (3)"

  it "gets game type options for display" do
    expect(TicTacToe::GameTypeOptions.for_display).to eq("#{HVH_OPTION} ; #{HVB_OPTION} ; #{BVH_OPTION}")
  end

  [1, 2, 3, TicTacToe::GameTypeOptions::HVH, TicTacToe::GameTypeOptions::HVB, TicTacToe::GameTypeOptions::BVH].map do |type| 
    it "finds #{type} is valid" do
      expect(TicTacToe::GameTypeOptions.is_valid_game_type?(type)).to eq(true) 
    end
  end
end
