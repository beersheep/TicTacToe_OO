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

  def empty_square
    @board.select {|_, value| value == " "}.keys
  end

  def no_space
    empty_square.size == 0
  end

  def check_for_empty(choice)
    if !empty_square.include?(choice)
      begin
      puts "The square has been taken, please select other squares."
      choice = gets.chomp.to_i
      end until empty_square.include?(choice)
    end
  end

end

class Player
  attr_reader :mark, :name
  attr_accessor :squares_taken

  def initialize(name, mark)
    @name = name
    @mark = mark
    @squares_taken = []
  end

  def take_square(choice)
    @squares_taken << choice
  end

  def check_win
    Game::WINNING_CONDITIONS.each do |line|
      return true if (line - squares_taken).empty?
    end
    return false
  end

end

class Game

  WINNING_CONDITIONS = [[1,2,3],[4,5,6],[7,8,9],
                       [1,4,7],[2,5,8],[3,6,9],
                       [1,5,9],[3,5,7]]


  def initialize 
    @player = Player.new(get_name, "O")
    @computer = Player.new("Computer", "X")
    @board = Board.new
    @current_player = @player
  end

  def get_name
    puts "What's your name?"
    gets.chomp
  end

  def pick_a_square
    if @current_player == @player
      puts "Please select a square(1-9):"
      choice = gets.chomp.to_i
      @board.check_for_empty(choice)
    else
      choice = @board.empty_square.sample
    end
    @board[choice] = @current_player.mark
    @current_player.take_square(choice)
  end

  def change_player
    if @current_player == @computer
      @current_player = @player
    else @current_player = @computer
    end
  end

  def play_again?
    puts "Would you like to play again?"
    reset if gets.chomp == "y"
  end

  def reset 
    @player.squares_taken = []
    @computer.squares_taken = []
    @board = Board.new
    @current_player = @player
  end

  def play
    @board.draw_board
    loop do 
      pick_a_square
      @board.draw_board
      if @current_player.check_win
        puts "#{@current_player.name} has won!"
        break
      end
      if @board.no_space
        puts "It's a tie!"
        break
      end
      change_player
    end
    play_again? ? play : (puts "Thank you for playing!")
  end

end

Game.new.play
