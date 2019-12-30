class Game
  attr_accessor :board, :player_1, :player_2

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

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    player_1.game = self
    @player_2 = player_2
    player_2.game = self
  end

  def current_player
    board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def turn_announcement
    puts "It's #{current_player.name}'s turn..."
  end

  def opposite_player
    current_player == player_1 ? player_2 : player_1
  end

  def won?
    WIN_COMBINATIONS.each do |win_combo|
      if win_combo.all? {|index| board.cells[index] == "X"} || win_combo.all? {|index| board.cells[index] == "O"}
        return win_combo
      end
    end
    false
  end

  def draw?
    board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    board.cells[won?.first] if won?
  end

  def turn
    turn_announcement
    move = current_player.move(self.board)
    if board.valid_move?(move)
      board.update(move, current_player)
      board.display
    else
      turn
    end
  end

  def play
    board.display
    until over?
      turn
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
    # new_game?
  end

  def self.welcome
    puts "Welcome to Tic Tac Toe!"
    puts "INSTRUCTIONS:"
    puts "Select the corresponding number to move your player into that space..."
    puts " 1 | 2 | 3 "
    puts "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts " 7 | 8 | 9 "
  end

  def self.create_player(player_token)
    puts "Select player type for player #{player_token}."
    print "Human or Computer: "
    player_type = gets.strip
    if player_type == "Human"
      print "What's your name? "
      player_name = gets.strip
      Players.const_get(player_type).new_with_name(player_token, player_name)
    elsif player_type == "Computer"
      Players.const_get(player_type).new_with_name(player_token)
    else
      puts "Invalid Command..."
      create_player(player_token)
    end

  end

  def self.setup
    p1 = create_player("X")
    p2 = create_player("O")
    Game.new(p1, p2)
  end

  def new_game?
    print "Play again? Yes or No: "
    user_input = gets.strip
    if user_input == "Yes"
      board.reset!
      puts "New game! Here we go!"
      play
    elsif user_input == "No"
      puts "Thanks for playing Tic Tac Toe!"
    else
      new_game?
    end
  end
end
