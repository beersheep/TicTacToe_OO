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

  # def [](position)
  #   @board[position]
  # end

  def []=(position, mark)
    @board[position] = mark
  end

  def empty_square
    @board.select {|pos, value| value == " "}.keys
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
  attr_accessor :current_player

  def initialize 
    @player = Player.new("Roy", "O")
    @computer = Player.new("Computer", "X")
    @board = Board.new
    @current_player = @player
  end

  def pick_a_square
    if @current_player == @player
      puts "Please select a square(1-9):"
      choice = gets.chomp.to_i
      begin
        if !@board.empty_square.include?(choice)
        puts "The square has been taken, please select other squares."
        choice = gets.chomp.to_i
      end until @board.empty_square.include?(choice)
        end
      @board[choice] = "O"
    else
      choice = @board.empty_square.sample
      @board[choice] = "X"
    end
  end

  def change_player
    if @current_player == @computer
      @current_player = @player
    else @current_player = @computer
    end
  end

  def play
    @board.draw_board
    
    pick_a_square
    change_player
    pick_a_square
    @board.draw_board
      
  end

end

Game.new.play

