require 'pry-byebug'
require_relative 'display'

class Game
  include Display

  def initialize
    @computer = Computer.new
    @human = Human.new
    @codebreaker_mode = false
    @codemaker_mode = false
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
        @codebreaker_mode = true
        play_as_codebreaker
        break
      when '2'
        @codemaker_mode = true
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
    display_computer_starting_game
    create_combinations_array
    ask_turns
  end

  def get_master_code
    while @human.make_code
      # Store the guess in an array and turn all the elements into integer
      @master_code = @human.code.split('')
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
      guess_code(turn)
      if @made_code == @guessed_code
        display_winning_message
        @game_won = true
        break
      end
    end
  end

  def guess_code(turn)
    if @codebreaker_mode
      get_guess(turn)
      display_guess(@computer.code, @guessed_code)
      @made_code = @computer.code
    else
      if @computer.code.nil?
        @computer.make_guess([1, 1, 2, 2])
      else
        @computer.make_guess(@combinations.sample)
      end
      display_guess(@master_code, @computer.code)
      reorganize_combinations_array
      @made_code = @master_code
      @guessed_code = @computer.code
    end
  end

  def reorganize_combinations_array
    combinations_clone = @combinations.clone
    combinations_clone.each do |combination|
      combination_clues = []
      set_clues(@computer.code, combination, combination_clues)
      if combination_clues != @clues
        @combinations.delete(combination)
      end
    end
  end

  def create_combinations_array
    combinations_clone = (1111..6666).to_a
    combinations_clone.map! { |combination| combination.to_s.split('') }
    @combinations = combinations_clone.clone
    combinations_clone.each do |combination|
      turn_into_integers(combination)
      if combination.any? { |n| (7..9).include?(n) || n.zero? }
        @combinations.delete(combination)
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
    while @human.make_code
      # Store the guess in an array and turn all the elements into integer
      @guessed_code = @human.code.split('')
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

  def display_guess(made_code, guessed_code)
    @colors = []
    @clues = []
    match_colors(guessed_code, @colors)
    set_clues(made_code, guessed_code, @clues)
    display_round_output(@colors, @clues)
  end

  def set_clues(made_code, guessed_code, clues)
    trial_code = made_code.clone
    guessed_code.each do |number|
      if trial_code.include?(number)
        if trial_code[trial_code.index(number)] == guessed_code[trial_code.index(number)]
          clues.push('🔴')
        else
          clues.push('⚪')
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
