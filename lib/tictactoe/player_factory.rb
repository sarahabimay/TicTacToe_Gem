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
        players = Hash[TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, TicTacToe::HumanPlayer.new(TicTacToe::Mark::O, display)]
      when TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[2]
        players = Hash[TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, TicTacToe::BeatableAIPlayer.new(TicTacToe::Mark::O, display)]
      when TicTacToe::GameTypeOptions::ID_TO_GAME_TYPE[3]
        players = Hash[TicTacToe::Mark::X, TicTacToe::BeatableAIPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, TicTacToe::HumanPlayer.new(TicTacToe::Mark::O, display)]
      else
        players = Hash[TicTacToe::Mark::X, TicTacToe::HumanPlayer.new(TicTacToe::Mark::X, display), TicTacToe::Mark::O, TicTacToe::HumanPlayer.new(TicTacToe::Mark::O, display)]
      end
      players
    end

    private

    attr_reader :display, :players
  end
end
