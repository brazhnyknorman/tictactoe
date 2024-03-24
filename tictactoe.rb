module Playable
  def input_check(symbol,index) # Check if square is open
    if $board.grid[index] == symbol
      puts "Someone is already there."
      exit
    end
  end

  def check_win # Check if player meets the win conditions
    if ($board.grid[0] == @symbol && $board.grid[1] == @symbol && $board.grid[2] == @symbol) || ($board.grid[3] == @symbol && $board.grid[4] == @symbol && $board.grid[5] == @symbol) || ($board.grid[6] == @symbol && $board.grid[7] == @symbol && $board.grid[8] == @symbol) || ($board.grid[0] == @symbol && $board.grid[3] == @symbol && $board.grid[6] == @symbol) || ($board.grid[1] == @symbol && $board.grid[4] == @symbol && $board.grid[7] == @symbol) || ($board.grid[2] == @symbol && $board.grid[5] == @symbol && $board.grid[8] == @symbol) || ($board.grid[0] == @symbol && $board.grid[4] == @symbol && $board.grid[8] == @symbol) || ($board.grid[2] == @symbol && $board.grid[4] == @symbol && $board.grid[6] == @symbol)
      puts "Player #{$board.current_turn} wins!"
      exit # Ends game
    end
  end

  def turn # Carries out the player's turn
    print "Coordinate: "
    @input = gets.chomp

    if $board.current_turn == "X"
      @symbol = "X"
    elsif $board.current_turn == "O"
      @symbol = "O"
    end

    case @input
    when "A1"
      input_check(@symbol,0)
      $board.grid=([0,@symbol])
      print $board.print_grid
    when "A2"
      input_check(@symbol,1)
      $board.grid=([1,@symbol])
      print $board.print_grid
    when "A3"
      input_check(@symbol,2)
      $board.grid=([2,@symbol])
      print $board.print_grid
    when "B1"
      input_check(@symbol,3)
      $board.grid=([3,@symbol])
      print $board.print_grid
    when "B2"
      input_check(@symbol,4)
      $board.grid=([4,@symbol])
      print $board.print_grid
    when "B3"
      input_check(@symbol,5)
      $board.grid=([5,@symbol])
      print $board.print_grid
    when "C1"
      input_check(@symbol,6)
      $board.grid=([6,@symbol])
      print $board.print_grid
    when "C2"
      input_check(@symbol,7)
      $board.grid=([7,@symbol])
      print $board.print_grid
    when "C3"
      input_check(@symbol,8)
      $board.grid=([8,@symbol])
      print $board.print_grid
    else
      puts "That was invalid input."
      exit
    end

    # If current player did not win this turn, queue the next player's turn
    check_win
    $board.switch_turn
    if $board.grid.include?(" ") == true
       $board.display_turn
    end
    
  end
end

class ActiveBoard

  attr_accessor :current_turn, :grid
  
  def initialize # initializes empty grid and Player X's turn
    @grid = [
      " ", " ", " ",
      " ", " ", " ", 
      " ", " ", " "
    ]
    @current_turn = "X"
  end

  def print_grid
    x =  (
      "\n    1 | 2 | 3  \n" + 
      "  |===========|\n" + 
      "A | #{@grid[0]} | #{@grid[1]} | #{@grid[2]} |  \n" + 
      "- |-----------|\n" + 
      "B | #{@grid[3]} | #{@grid[4]} | #{@grid[5]} |  \n" + 
      "- |-----------|\n" + 
      "C | #{@grid[6]} | #{@grid[7]} | #{@grid[8]} |  \n" + 
      "  |===========|\n"
    )
    return x
  end

  def display_turn
    puts "\n\nIt is now #{current_turn}'s turn."
  end

  def grid=(new_grid = [])
    @grid[new_grid[0]] = new_grid[1]
  end

  def switch_turn
    case @current_turn
    when "O"
      @current_turn = "X"
    when "X"
      @current_turn = "O"
    end
  end
end

class Player
  include Playable
end

def game_start(command)
  puts "Welcome to Tic Tac Toe!"
  puts "This is the board that\nyou'll be playing with:\n\n"
  puts command
  puts "\n\nWhen it is your turn, simply\ntype in the coordinate for"
  puts "your turn, such as 'A1' or 'C3'."
end

game_over = false

$board = ActiveBoard.new
players = Player.new
game_start($board.print_grid)

while game_over == false
  $board.display_turn
  9.times {players.turn}

  puts "This game is a draw."
  game_over = true
end