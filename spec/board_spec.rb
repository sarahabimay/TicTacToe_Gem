require "tictactoe/board"
require "tictactoe/board_options"

RSpec.describe TicTacToe::Board do
  let(:dimension) { TicTacToe::BoardOptions::DIMENSIONS["THREE_BY_THREE"] }
  let(:my_three_by_three_board) { TicTacToe::Board.new(dimension) }

  context "Three by Three Board" do
    it "creates a Board instance representing a 3x3 game" do
      expect(my_three_by_three_board.board_size()).to eq(9)
    end

    it "places a mark in a given position" do
      new_board = my_three_by_three_board.play_mark(TicTacToe::Mark::X, 4)
      expect(my_three_by_three_board.find_mark_in_position(4)).to eq(TicTacToe::Mark::X)
    end

    [0, 10, "10"].each do |position|
      it "validates to false for position #{position}" do
        expect(my_three_by_three_board.valid_position?(position)).to eq(false)
      end
    end

    [1, 9, "1"].each do |position|
      it "correctly validates to true if a position exist #{position}" do
        expect(my_three_by_three_board.valid_position?(position)).to eq(true)
      end
    end

    [0, 10].each do |position|
      it "raises an 'InvalidMove' error when trying to place mark in position: #{position}" do
        expect{ my_three_by_three_board.play_mark(TicTacToe::Mark::X, position) }.
          to raise_error(ArgumentError, "Invalid Board Position")
      end
    end

    it "is unable to place a Mark in a position already taken" do
      board_with_some_positions = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O], [TicTacToe::Mark::O, TicTacToe::Mark::O, 6], [7, 8, 9]])
      expect{ board_with_some_positions.play_mark(TicTacToe::Mark::X, 3) }.
        to raise_error(ArgumentError, "Position Already Taken")
    end

    it "knows Mark::X is the next Mark to be played" do
      board_with_some_positions = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::O], [TicTacToe::Mark::O, TicTacToe::Mark::O, 6], [7, 8, 9]])
      expect(board_with_some_positions.next_mark_to_play).to eq(TicTacToe::Mark::X)
    end

    it "knows Mark::O is the next Mark to be played" do
      board_with_some_positions = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::X], [TicTacToe::Mark::O, TicTacToe::Mark::O, 6], [7, 8, 9]])
      expect(board_with_some_positions.next_mark_to_play).to eq(TicTacToe::Mark::O)
    end

    context "finding win, draw or neither" do
      it "is not game over" do
        expect(my_three_by_three_board.is_game_over?()).to eq(false)
      end

      it "is game over as no spaces left" do
        full_board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::O, TicTacToe::Mark::O], [TicTacToe::Mark::X, TicTacToe::Mark::O, TicTacToe::Mark::X],[TicTacToe::Mark::X, TicTacToe::Mark::O, TicTacToe::Mark::X]])
        expect(full_board.spaces_available?()).to eq(false)
      end

      it "game over with win in column 1" do
        column_win_board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, "2", "3"], [TicTacToe::Mark::X, "5", "6"],[TicTacToe::Mark::X, "8", "9"]])
        expect(column_win_board.is_game_over?()).to eq(true)
      end

      it "game over with win in column 2" do
        column_win_board = TicTacToe::Board.new(dimension, [["1", TicTacToe::Mark::X, "3"], ["4", TicTacToe::Mark::X, "6"],["7", TicTacToe::Mark::X, "9"]])
        expect(column_win_board.is_game_over?()).to eq(true)
      end

      it "game over with win in row 1" do
        row_win_board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::X], ["4", "5", "6"],["7", "8", "9"]])
        expect(row_win_board.is_game_over?()).to eq(true)
      end

      it "game over with win in row 3" do
        row_win_board = TicTacToe::Board.new(dimension, [["1", "2", "3"], ["4", "5", "6"],[TicTacToe::Mark::X, TicTacToe::Mark::X, TicTacToe::Mark::X]])
        expect(row_win_board.is_game_over?()).to eq(true)
      end

      it "game over with win in diagonal 1" do
        diag_win_board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, "2", "3"], ["4", TicTacToe::Mark::X, "6"],["7", "8", TicTacToe::Mark::X]])
        expect(diag_win_board.is_game_over?()).to eq(true)
      end

      it "find winning player is Mark::X" do
        x_win_board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::X, "2", "3"], ["4", TicTacToe::Mark::X, "6"],["7", "8", TicTacToe::Mark::X]])
        expect(x_win_board.get_winning_mark).to eq(TicTacToe::Mark::X)
      end

      it "find no winning player" do
        x_win_board = TicTacToe::Board.new(dimension, [[TicTacToe::Mark::O, "2", "3"], ["4", TicTacToe::Mark::X, "6"],["7", "8", TicTacToe::Mark::X]])
        expect(x_win_board.get_winning_mark).to eq(nil)
      end
    end
  end
end
