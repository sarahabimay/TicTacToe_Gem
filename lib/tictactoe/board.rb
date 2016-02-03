require 'enumerator'
require "tictactoe/mark"

module TicTacToe
  class Board 
    attr_reader :board_size, :board_cells

    ZERO_INDEX_OFFSET = 1
    LOWER_INDEX_LIMIT = 1

    def initialize(dimension, cells = [])
      @dimension = dimension 
      @board_size = @dimension * @dimension
      @board_cells = create_board_cells(cells)
    end

    def create_board_cells(cells)
      return cells if !cells.nil? && cells.flatten.length > 0
      Array.new(@dimension) { Array.new(@dimension) }
    end

    def play_mark_in_position(mark, position_key)
      raise ArgumentError, "Invalid Board Position" if !valid_position?(position_key)
      raise ArgumentError, "Position Already Taken" if position_occupied?(position_key)
      flattened = @board_cells.flatten
      flattened[position_key.to_i - ZERO_INDEX_OFFSET] = mark
      @board_cells = flattened.each_slice(@dimension).to_a
      Board.new(@dimension, @board_cells)
    end

    def valid_position?(position_key)
      return false if position_key.to_i < LOWER_INDEX_LIMIT
      return false if position_key.to_i > @board_size
      true
    end

    def position_occupied?(position_key)
      Mark.is_a_mark?(find_mark_in_position(position_key.to_i))
    end

    def find_mark_in_position(position_key)
      flattened = @board_cells.flatten
      flattened[position_key.to_i - ZERO_INDEX_OFFSET]
    end

    def next_mark_to_play
      return TicTacToe::Mark::O if number_of_positions_for_mark(TicTacToe::Mark::O) < number_of_positions_for_mark(TicTacToe::Mark::X)
      Mark::X
    end

    def number_of_positions_for_mark(mark)
      flat_board = @board_cells.flatten
      flat_board.find_all { |x| x == mark }.size
    end

    def get_winning_mark
      return nil if !is_game_over?
      return TicTacToe::Mark::X if found_win_for_mark(TicTacToe::Mark::X)
      return TicTacToe::Mark::O if found_win_for_mark(TicTacToe::Mark::O)
      return nil
    end

    def is_game_over?
      !spaces_available? || found_win  
    end

    def spaces_available?
      number_of_positions_for_mark(TicTacToe::Mark::X) + number_of_positions_for_mark(TicTacToe::Mark::O) != @board_size 
    end

    def found_win_for_mark(mark)
      find_column_win_for_mark(mark) || find_row_win_for_mark(mark, @board_cells) || find_diagonal_win_for_mark(mark)
    end

    def found_win
      found_win_in_columns || found_win_in_rows || found_win_in_diagonals
    end

    def found_win_in_columns
      find_column_win_for_mark(TicTacToe::Mark::X) || find_column_win_for_mark(TicTacToe::Mark::O)
    end

    def find_column_win_for_mark(mark)
      find_row_win_for_mark(mark, @board_cells.transpose)
    end

    def found_win_in_rows
      find_row_win_for_mark(TicTacToe::Mark::X, @board_cells) || find_row_win_for_mark(TicTacToe::Mark::O, @board_cells)
    end

    def find_row_win_for_mark(mark, board)
      board.collect{ |row| row.all? { |a_mark| a_mark == mark } }.any? { |result| result == true }
    end

    def found_win_in_diagonals
      find_diagonal_win_for_mark(TicTacToe::Mark::X) || find_diagonal_win_for_mark(TicTacToe::Mark::O)
    end

    def find_diagonal_win_for_mark(mark)
      find_row_win_for_mark(mark, get_diagonal_marks)
    end

    def get_diagonal_marks
      diagonal_marks = board_cells.map.with_index do |row, i|
        row[i]
      end
      diagonal_marks.push(*board_cells.reverse.map.with_index do |row, i|
        row[i]
      end)
      diagonal_marks = diagonal_marks.each_slice(@dimension).to_a
    end
  end
end
