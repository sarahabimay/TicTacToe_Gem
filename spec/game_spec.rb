require "tictactoe/board"
require "tictactoe/board_options"
require "tictactoe/game"
require "tictactoe/human_player"
require "tictactoe/beatable_ai_player"
require "tictactoe/game_type_options"
require "human_player_fake"

RSpec.describe TicTacToe::Game do
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:ui_double) { double("UserInterface").as_null_object }
  let(:player1_spy) { instance_spy(TicTacToe::HumanPlayer) }
  let(:player2_spy) { instance_spy(TicTacToe::HumanPlayer) }
  let(:hvh) { TicTacToe::GameTypeOptions::GAME_OPTIONS["HVH"] }

  it "game has two players" do
    game = TicTacToe::Game.new(TicTacToe::Board.new(dimension), hvh, ui_double, [player1_spy, player2_spy])
    expect(game.players.length).to eq(2)
  end

  it "keeps playing until game over" do
    allow(ui_double).to receive(:display_board)
    expect(player1_spy).to receive(:get_next_move).and_return("6", "7")
    expect(player2_spy).to receive(:get_next_move).and_return("8", "9")
    board = TicTacToe::Board.new(
      dimension,
      [
        [TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O],
        [TicTacToe::Mark::O, TicTacToe::Mark::X, 6],
        [7, 8, 9]
      ])
    a_game = TicTacToe::Game.new(
      board,
      hvh,
      ui_double,
      Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy])
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end

  it "displays board to UI via board displayer" do
    expect(player1_spy).to receive(:get_next_move).and_return("6", "7")
    expect(player2_spy).to receive(:get_next_move).and_return("8", "9")
    allow(ui_double).to receive(:display_board)
    board = TicTacToe::Board.new(
      dimension,
      [
        [TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O],
        [TicTacToe::Mark::O, TicTacToe::Mark::X, 6],
        [7, 8, 9]
      ])
    a_game = TicTacToe::Game.new(
      board,
      hvh,
      ui_double,
      Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy])
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end
end
