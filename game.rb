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
    get_guess(1)
    display_user_guess
    if @computer.code == @guessed_code
      puts "You broke the code. Congratulations!"
    end

  end

  def get_guess(n)
    display_prompt_for_guess(n)
    while @human.make_guess
      # Store the guess in an array and turn all the elements into integer
      @guessed_code = @human.guess.split('')
      @guessed_code.map! { |number| number.to_i }

      # Check if the guess contains 4 digits
      if @guessed_code.length != 4 || !@guessed_code.all?(Integer) || !@guessed_code.all? { |n| (1..6).include?(n) }
        display_warning
      else
        break
      end
    end
  end

  def display_user_guess
    colors = []
    clues = []
    match_colors(colors)
    trial_code = @guessed_code
    @computer.code.each_with_index do |number, index|
      if trial_code.include?(number)
        if number == trial_code[index]
          clues.push('🔴')
          trial_code[index] = nil
        else
          clues.push('⚪')
        end
      else
        next
      end
    end

    puts "\n"
    puts "Computer code: #{@computer.code}"
    puts "#{colors.join(' ')}  Clues: #{clues.join(' ')}"
  end

  def match_colors(colors)
    @guessed_code.each do |number|
      case number
      when 1
        colors.push('  1  '.bg_red)
      when 2
        colors.push('  2  '.bg_green)
      when 3
        colors.push('  3  '.bg_brown)
      when 4
        colors.push('  4  '.bg_blue)
      when 5
        colors.push('  5  '.bg_magenta)
      when 6
        colors.push('  6  '.bg_cyan)
      end
    end
  end
end
