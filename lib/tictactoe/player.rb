module Player
  def get_opponent_mark
    TicTacToe::Mark::X if mark == TicTacToe::Mark::O
    TicTacToe::Mark::O if mark == TicTacToe::Mark::X
  end

  def is_ready?
    true
  end

  private

  attr_reader :mark
end
