require "tictactoe/player"

module TicTacToe
  class BeatableAIPlayer
    include Player

    def initialize(mark, display)
      @mark = mark
      @display = display
    end

    def get_next_move(board)
      move = randomized_move(board)
      display.announce_player_move(mark, move)
      move
    end

    def randomized_move(board)
      rand(1..board.board_size)
    end

    private

    attr_reader :mark, :display
  end
end
