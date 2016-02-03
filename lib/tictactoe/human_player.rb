require "tictactoe/mark"
require "tictactoe/player"

module TicTacToe
  class HumanPlayer
    include Player

    def initialize(mark, display)
      @mark = mark
      @display = display
    end

    def get_next_move(board)
      display.ask_player_for_move(mark)
    end

    private

    attr_reader :display, :mark
  end
end
