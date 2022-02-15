require 'pry-byebug'
require_relative 'display'

class Game
  include Display

  def initialize
    @computer = Computer.new
    @human = Human.new
  end

  def play
    explain_game
    @computer.make_code
    display_starting_of_game
    puts "\nTurn 1: Type in four numbers to guess the code:"
    get_guess
    p @computer.code
    p @guessed_code
  end

  def get_guess
    while @human.make_guess
      # Store the guess in an array and turn all the elements into integer
      @guessed_code = @human.guess.split('')
      @guessed_code.map! { |number| number.to_i }

      # Check if the guess contains 4 digits
      if @guessed_code.length != 4 || !@guessed_code.all?(Integer) || @guessed_code.include?(0)
        puts 'Your guess should only be 4 digits between 1 and 6, inclusive.'.red
      else
        break
      end
    end
  end

end
