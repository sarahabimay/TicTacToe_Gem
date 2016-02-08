module TicTacToe
  class Game
    attr_reader :players, :game_type, :board

    def initialize(board, game_type, user_interface, players)
      @board = board
      @game_type = game_type
      @user_interface = user_interface
      @players = players
    end

    def get_winning_mark
      @board.get_winning_mark
    end

    def find_player_by_mark(mark)
      return players[mark] if players.has_key?(mark)
    end

    def play_turns
      while !board.is_game_over? && next_player.is_ready? do
        begin
          display_board
          play_next_move
        rescue ArgumentError  => error
          p "#{error.class} and #{error.message}"
        end
      end
      display_board
      @board
    end

    private

    def play_next_move
      @board = board.play_mark_in_position(board.next_mark_to_play, next_player.get_next_move(board))
    end

    def display_board
      user_interface.display_board(board)
    end
    
    def next_player
      find_player_by_mark(board.next_mark_to_play)
    end
    attr_reader :user_interface
  end
end
