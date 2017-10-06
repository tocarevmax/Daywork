require_relative 'tile.rb'

class Board
attr_accessor :grid

  def initialize(board_size = 9)
    @grid = Array.new(board_size) { Array.new(board_size) }
  end

  def populate
    generate_tiles
    place_tiles_on_grid
    assign_adj_bomb_count
  end

  def generate_tiles
    bomb_count = @grid.length ** 2 / 5
    total_tiles = @grid.length ** 2
    bomb_count.times do
      Tile.new(true)
    end
    (total_tiles - bomb_count).times do
      Tile.new
    end
  end

  def place_tiles_on_grid
    i = 0
    shuffled_tiles = Tile::ALL.shuffle
    @grid.each.with_index do |row, row_idx|
      row.each.with_index do |col, col_idx|
        @grid[row_idx][col_idx] = shuffled_tiles[i]
        shuffled_tiles[i].pos = [row_idx,col_idx]
        i += 1
      end
    end
    # current_tile.pos = [x,y]
  end

  def assign_adj_bomb_count
    # @grid.each do |row|
    #   row.each do |tile|
    #     count_adjacent_bombs(tile.pos)
    #   end
    # end
    how_many_bombs_itirated = 0
    Tile::ALL.each do |tile|
      # count_adjacent_bombs(tile.pos)
      tile.adjacent_bomb = count_adjacent_bombs(tile.pos)
      how_many_bombs_itirated += 1
    end
    p how_many_bombs_itirated
  end

  def count_adjacent_bombs(pos)
    counter = 0
    x = pos.first
    y = pos.last

    xy_pairs = [[x-1, y-1], [x, y-1], [x+1, y-1], [x-1, y],
     [x+1, y], [x-1, y+1], [x, y+1], [x+1, y+1]]

    valid_pairs = []
    xy_pairs.each do |pos|
      x, y = pos
      if x.between?(0,@grid.length-1) && y.between?(0, @grid.length-1)
        valid_pairs << pos
      end
    end

    valid_pairs.each do |pair|
      # p "current pair: #{pair}"
      x = pair.first
      y = pair.last

      # p "@grid[#{x}][#{y}] = #{@grid[x][y]}"
      counter += 1 if @grid[x][y].bomb
    end
    counter
    # @grid[x][y].adjacent_bomb =
  end

  def render
    @grid.each do |row|
      i = 0
      while i < 9
        print "| #{row[i].adjacent_bomb} #{row[i].bomb} |"
        i += 1
      end
      puts
      # @row.each do |tile|
      #
      # end
    end
  end
end



board = Board.new
board.populate
#p board.grid[0][0]
# Tile::ALL.each {|el| p el}
board.render

# board.grid.each do |row|
#   row.each do |tile|
#     p tile
#   end
# end
