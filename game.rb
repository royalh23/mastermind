require 'pry-byebug'
require_relative 'display'

class Game
  include Display

  def initialize
    @computer = Computer.new
    @human = Human.new
    @game_won = false
  end

  def play
    explain_game
    display_gameplay_choice_question
    while (answer = gets.chomp)
      case answer
      when '1'
        play_as_codebreaker
        break
      when '2'
        play_as_codemaker
        break
      else
        puts 'Please enter a valid choice.'
      end
    end
  end

  def play_as_codebreaker
    @computer.make_code
    display_starting_of_game
    ask_turns
    check_game_end_state
  end

  def play_as_codemaker; end

  def ask_turns
    12.times do |turn|
      get_guess(turn)
      display_user_guess
      if @computer.code == @guessed_code
        display_winning_message
        @game_won = true
        break
      end
    end
  end

  def check_game_end_state
    if @game_won == false
      display_game_over_message
    end
  end

  def get_guess(turn)
    display_prompt_for_guess(turn)
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
    @colors = []
    @clues = []
    match_colors(@guessed_code, @colors)
    set_clues
    display_round_output(@colors, @clues)
  end

  def set_clues
    trial_code = @computer.code.clone
    @guessed_code.each do |number|
      if trial_code.include?(number)
        if trial_code[trial_code.index(number)] == @guessed_code[trial_code.index(number)]
          @clues.push('🔴')
        else
          @clues.push('⚪')
        end
        trial_code[trial_code.index(number)] = nil
      else
        next
      end
    end
  end

  def match_colors(code, colors)
    code.each do |number|
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
