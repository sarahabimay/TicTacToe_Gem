module TicTacToe 
  class GameTypeOptions
    GAME_OPTIONS = {
      "HVH" => "Human Vs Human",
      "HVB" => "Human Vs Easy AI",
      "BVH" => "Easy AI Vs Human"
    }

    ID_TO_GAME_TYPE = {
      1 => "HVH",
      2 => "HVB",
      3 => "BVH",
    }

    def self.is_valid_game_type?(type)
      return false if type.nil?
      ID_TO_GAME_TYPE.include?(type.to_i)
    end

    def self.lookup_game_type_for_id(id)
      ID_TO_GAME_TYPE.fetch(id.to_i, nil)
    end

    def self.for_display
      ID_TO_GAME_TYPE.collect do |id_to_type|
        "#{id_to_type.first} -> #{GAME_OPTIONS[id_to_type.last]}"
      end.join("\n")
    end
  end
end
