require "tictactoe/game"
require "tictactoe/human_player"
require "tictactoe/beatable_ai_player"
require "human_player_fake"

RSpec.describe TicTacToe::Game do
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:ui_double) { double("UserInterface").as_null_object }
  let(:player1_spy) { instance_spy(TicTacToe::HumanPlayer) }
  let(:player2_spy) { instance_spy(TicTacToe::HumanPlayer) }

  it "game has two players" do
    game = TicTacToe::Game.new(
      TicTacToe::Board.new(dimension), 
      HVH, 
      ui_double, 
      Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy]) 
    expect(game.players.length).to eq(2)
  end
 
  it "can find player by it's mark" do
    game = TicTacToe::Game.new(
      TicTacToe::Board.new(dimension), 
      HVH, 
      ui_double,
      Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy]) 
    expect(game.find_player_by_mark(TicTacToe::Mark::X)).to eq(player1_spy)
    expect(game.find_player_by_mark(TicTacToe::Mark::O)).to eq(player2_spy)
  end

  it "two human players are ready to play" do
    game = TicTacToe::Game.new(
      TicTacToe::Board.new(dimension), 
      HVB, 
      ui_double, 
      Hash[TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, ui_double), 
        TicTacToe::Mark::O, TicTacToe::BeatableAIPlayer.new(TicTacToe::Mark::O, ui_double)]) 
    players = game.players
    expect(players[TicTacToe::Mark::X].is_ready?).to eq(true)
    expect(players[TicTacToe::Mark::O].is_ready?).to eq(true)
  end

  it "won't play as next player isn't ready" do
    board = TicTacToe::Board.new(dimension)
    game = TicTacToe::Game.new(
      board, 
      HVH, 
      ui_double, 
      Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy]) 
    expect(player1_spy).to receive(:is_ready?).and_return(false) 
    game.play_turns
    expect(board).to eq(board)
  end

  it "keeps playing until game over" do
    allow(ui_double).to receive(:display_board)
    expect(player1_spy).to receive(:get_next_move).and_return("6", "7")
    expect(player2_spy).to receive(:get_next_move).and_return("8", "9")
    board = TicTacToe::Board.new(
      dimension, 
      [
        [TicTacToe::Mark::X,  TicTacToe::Mark::X, TicTacToe::Mark::O], 
        [TicTacToe::Mark::O,  TicTacToe::Mark::X, 6], 
        [7,                   8,                  9]])

    a_game = TicTacToe::Game.new(
      board, 
      HVH, 
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
        [TicTacToe::Mark::X, TicTacToe::Mark::X,  TicTacToe::Mark::O], 
        [TicTacToe::Mark::O, TicTacToe::Mark::X,  6], 
        [7,                  8,                   9]])
    a_game = TicTacToe::Game.new(
      board, 
      HVH, 
      ui_double, 
      Hash[TicTacToe::Mark::X, player1_spy, TicTacToe::Mark::O, player2_spy]) 
    board = a_game.play_turns
    expect(board.is_game_over?).to eq(true)
  end
end
