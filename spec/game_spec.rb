require "tictactoe/game"
require "human_player_fake"

RSpec.describe TicTacToe::Game do
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:ui_double) { double("UserInterface").as_null_object }
  let(:player1_fake) { instance_spy(TicTacToe::HumanPlayer) }
  let(:player2_fake) { instance_spy(TicTacToe::HumanPlayer) }

  it "game has two players" do
    game = TicTacToe::Game.new(TicTacToe::Board.new(dimension), HVH, ui_double, [player1_fake, player2_fake]) 
    expect(game.players.length).to eq(2)
  end
  
  it "keeps playing until game over" do
    allow(ui_double).to receive(:display_board)
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O], [TicTacToe::Mark::O, TicTacToe::Mark::X, 6], [7, 8, 9]])
    a_game = TicTacToe::Game.new(board, HVH, ui_double, Hash[TicTacToe::Mark::X, player1_fake, TicTacToe::Mark::O, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end

  it "displays board to UI via board displayer" do
    expect(player1_fake).to receive(:get_next_move).and_return("6", "7")
    expect(player2_fake).to receive(:get_next_move).and_return("8", "9")
    allow(ui_double).to receive(:display_board)
    board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O], [TicTacToe::Mark::O, TicTacToe::Mark::X, 6], [7, 8, 9]])
    a_game = TicTacToe::Game.new(board, HVH, ui_double, Hash[TicTacToe::Mark::X, player1_fake, TicTacToe::Mark::O, player2_fake]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end
end
