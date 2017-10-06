class Game

  def get_pos
    pos = [0]
    until valid_pos(pos)
      p "please provide coordinates for a position [0, 0]"
      pos = parse_pos(gets.chomp)
    end

    pos
  end

  def valid_pos?(pos)
    return false if pos == [0]
    x = pos.first
    y = pos.last

    if pos.first.between?()
  end

  def parse_pos(string_pos)
    string_pos.split(",").map(&:to_i)
  end

  def get_move
    input = nil
    until input.downcase == "f" || input.downcase == "r"
      p "would you like to flag (f) or reveal (r) at the position"
      input = gets.chomp
    end

    input
  end

  def play_move
    if board[pos].flagged && move == "f"
      board[pos].flagged = false
    elsif !board[pos].flagged && move == "f"
      board[pos].flagged = true
    end
  end

  def won?
    all_not_bombs = Tile::ALL.select {|tile| ! tile.bomb }
    all_not_bombs.all? {|not_bomb| not_bomb.revealed}
  end

end
