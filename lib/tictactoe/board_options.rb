module TicTacToe
  class BoardOptions

    DIMENSIONS = {
      "THREE_BY_THREE" => 3
    }

    def self.is_valid_dimension?(dimension)
      DIMENSIONS.value?(dimension.to_i)
    end
  end
end
