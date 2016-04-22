require "tictactoe/human_player"
require "tictactoe/beatable_ai_player"

module TicTacToe
  class PlayerFactory

    def initialize(display)
      @players = []
      @display = display
    end

    def get_players_for_game_type(game_type)
      case TicTacToe::GameTypeOptions.lookup_game_type_for_id(game_type)
      when TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[1]
        Hash[
          TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display),
          TicTacToe::Mark::O, TicTacToe::HumanPlayer.new(TicTacToe::Mark::O, display)
        ]
      when TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[2]
        Hash[
          TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display),
          TicTacToe::Mark::O, TicTacToe::BeatableAIPlayer.new(TicTacToe::Mark::O, display)
        ]
      when TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[3]
        Hash[
          TicTacToe::Mark::X, TicTacToe::BeatableAIPlayer.new(TicTacToe::Mark::X, display),
          TicTacToe::Mark::O, TicTacToe::HumanPlayer.new(TicTacToe::Mark::O, display)
        ]
      else
        Hash[
          TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display),
          TicTacToe::Mark::O, TicTacToe::HumanPlayer.new(TicTacToe::Mark::O, display)
        ]
      end
    end

    private

    attr_reader :display, :players
  end
end
