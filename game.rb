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
    select_game_mode
  end

  def select_game_mode
    while (answer = gets.chomp)
      case answer
      when '1'
        play_as_codebreaker
        break
      when '2'
        play_as_codemaker
        break
      else
        display_valid_choice_warning
      end
    end
  end

  def play_as_codebreaker
    @computer.make_code
    display_starting_of_game
    ask_turns
    check_game_end_state
  end

  def play_as_codemaker
    display_prompt_for_making_code
    get_master_code
  end

  def get_master_code
    while (m_code = gets.chomp)
      # Store the guess in an array and turn all the elements into integer
      @master_code = m_code.split('')
      turn_into_integers(@master_code)

      if code_is_false?(@master_code)
        display_warning('code')
      else
        break
      end
    end
  end

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
      turn_into_integers(@guessed_code)

      if code_is_false?(@guessed_code)
        display_warning('guess')
      else
        break
      end
    end
  end

  def turn_into_integers(code)
    code.map! { |number| number.to_i }
  end

  def code_is_false?(code)
    code.length != 4 || !code.all?(Integer) || !code.all? { |n| (1..6).include?(n) }
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
