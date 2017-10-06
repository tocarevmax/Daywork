class Tile
  ALL = []

  def initialize(bomb = false)
    @flagged = false
    @revealed = false
    @bomb = bomb
    ALL << self
  end

  attr_accessor :flagged, :bomb, :adjacent_bomb, :pos





end
