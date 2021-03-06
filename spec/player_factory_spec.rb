require "tictactoe/player_factory"
require "tictactoe/game_type_options"
require "stringio"

RSpec.describe TicTacToe::PlayerFactory do
  let(:display_double) { double("UserInterface").as_null_object }
  let(:factory) { TicTacToe::PlayerFactory.new(display_double) }
  HVH = 1
  HVB = 2
  BVH = 3

  it "creates a list of two HumanPlayers" do
    players = factory.get_players_for_game_type(HVH)
    expect(players[TicTacToe::Mark::X]).to be_a(TicTacToe::HumanPlayer)
    expect(players[TicTacToe::Mark::O]).to be_a(TicTacToe::HumanPlayer)
  end

  it "creates a Human and Beatable AI Player for HVB games" do
    players = factory.get_players_for_game_type(HVB)
    expect(players[TicTacToe::Mark::X]).to be_a(TicTacToe::HumanPlayer)
    expect(players[TicTacToe::Mark::O]).to be_a(TicTacToe::BeatableAIPlayer)
  end

  it "creates a Beatable AI and Human player for BVH games" do
    players = factory.get_players_for_game_type(BVH)
    expect(players[TicTacToe::Mark::X]).to be_a(TicTacToe::BeatableAIPlayer)
    expect(players[TicTacToe::Mark::O]).to be_a(TicTacToe::HumanPlayer)
  end
end
