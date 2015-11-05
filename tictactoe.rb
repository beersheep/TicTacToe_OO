require 'pry'

class Board
  attr_reader :board

  def initialize
    @board = {}
    (1..9).each {|position| board[position] = " "}
  end

  def draw_board
    system "clear"
    puts 
    puts "    |    |    "
    puts " #{board[1]}  | #{board[2]}  | #{board[3]}  "
    puts "——————————————"
    puts "    |    |    "
    puts " #{board[4]}  | #{board[5]}  | #{board[6]}  "
    puts "——————————————"
    puts "    |    |    "
    puts " #{board[7]}  | #{board[8]}  | #{board[9]}  "
  end

  def []=(position, mark)
    @board[position] = mark
  end
end

class Player
  attr_reader :board
  def initialize(name, mark)
    @name = name
    @mark = mark
    @squares_taken = []
  end
end

class Game
  def initialize 
    @player = Player.new("Roy", "O")
    @computer = Player.new("Computer", "X")
    @board = Board.new
  end

  def pick_a_square
    puts "Please select a square(1-9):"
    choice = gets.chomp.to_i
    @board[choice] = "O"
  end

  def play
    @board.draw_board
    pick_a_square
    @board.draw_board
  end

end
# binding.pry
Game.new.play

