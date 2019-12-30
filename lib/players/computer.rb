class Players

  class Computer < Player

    WIN_COMBINATIONS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [6,4,2]
    ]

    def available_moves
      moves = []
      game.board.cells.each_with_index do |cell, index|
        moves << index if cell == " "
      end
      moves
    end

    def move(board)
      (1..9).to_a.sample.to_s
      # print check_win_combo
      # (available_moves.sample + 1).to_s
    end

    def check_win_combo
      WIN_COMBINATIONS.detect do |combo|
         combo.count {|index| game.board.cells[index] == game.opposite_player.token} > 1
      end
    end
  end
end
