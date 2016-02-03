require "tictactoe/game_type_options"

RSpec.describe TicTacToe::GameTypeOptions do
  HVH_OPTION = "Human Vs Human"
  HVB_OPTION = "Human Vs Easy AI"
  BVH_OPTION = "Easy AI Vs Human"

  it "gets game type options for display" do
    expect(TicTacToe::GameTypeOptions.for_display).to eq("1 -> #{HVH_OPTION}\n2 -> #{HVB_OPTION}\n3 -> #{BVH_OPTION}")
  end

  [1, 2, 3, "1", "2", "3" ].map do |type| 
    it "finds #{type} is valid" do
      expect(TicTacToe::GameTypeOptions.is_valid_game_type?(type)).to eq(true) 
    end
  end

  [0, 4, "a", "HVH", nil].map do |type| 
    it "finds #{type} is invalid" do
      expect(TicTacToe::GameTypeOptions.is_valid_game_type?("HVH")).to eq(false) 
    end
  end

  it "look up game type for numerical options" do
    expect(TicTacToe::GameTypeOptions.lookup_game_type_for_id(1)).to eq("HVH")
    expect(TicTacToe::GameTypeOptions.lookup_game_type_for_id(2)).to eq("HVB")
    expect(TicTacToe::GameTypeOptions.lookup_game_type_for_id(3)).to eq("BVH")
  end
end
