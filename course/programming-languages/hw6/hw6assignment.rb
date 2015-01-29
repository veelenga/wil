# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  All_My_Pieces = All_Pieces +
    [
      rotations([[0, 0], [0, 1], [1, 0]]),
      [
        [[0, 0], [-1, 0], [1, 0], [2, 0], [-2, 0]],
        [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]
      ],
      rotations([[0, 0], [-1, 0], [1, 0], [-1, 1], [0, 1]])
    ]

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
end

class MyBoard < Board

  CHEAT_COST = 100

  def initialize(game)
    super(game)
    @current_block = MyPiece.next_piece(self)
    @cheating = false
  end

  def next_piece
    if @cheating and @score >= CHEAT_COST
      @current_block = MyPiece.new([[[0, 0]]], self)
      @score -= CHEAT_COST
    else
      @current_block = MyPiece.next_piece(self)
    end
    @cheating = false
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    locations.size.times{|index|
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def cheat
    @cheating = true
  end

  def rotate_180
    if !game_over? and @game.is_running?
      if !@current_block.move(0, 0, -2)
        @current_block.move(0, 0, 2)
      end
    end
  end

end

class MyTetris < Tetris

  def initialize
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat})
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new (self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
end
