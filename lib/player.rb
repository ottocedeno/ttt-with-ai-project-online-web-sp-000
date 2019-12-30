class Player
  attr_accessor :name, :game
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def self.new_with_name(token, name = "The Computer")
    self.new(token).tap {|new_player| new_player.name = name}
  end

end
