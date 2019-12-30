class Players

  class Human < Player

    def move(board)
      puts "Please make a valid move between 1-9:"
      user_input = gets.strip
    end
  end
end
