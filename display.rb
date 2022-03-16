# Text needed for Mastermind

module Display
  def explain_game
    introduce_game
    display_rules
    display_note
    display_last_example
  end

  def introduce_game
    puts <<~HEREDOC
      \n#{'Welcome to Mastermind!'.bold}
      \nIn this game, you will be playing against the computer as one of the following:
      \n\t- The #{'codebreaker'.gray.bold}
      \t- The #{'codemaker'.gray.bold}
    HEREDOC
  end

  def display_rules
    puts <<~HEREDOC
      \nThe #{'codemaker'.gray.bold} makes the code, which is a
      sequence of four colors chosen from the following:
      \n#{'  1  '.bg_red} #{'  2  '.bg_green} #{'  3  '.bg_brown} #{'  4  '.bg_blue} #{'  5  '.bg_magenta} #{'  6  '.bg_cyan}
      \nAn example of a code:
      \n#{'  2  '.bg_green} #{'  4  '.bg_blue} #{'  6  '.bg_cyan} #{'  2  '.bg_green}
      \nAs you can see, there can be more than one of the same color.
      The #{'codebreaker'.gray.bold} attempts to guess the code in 12 or fewer turns.
      After each guess, clues will be given in the form of colors.
      \n🔴 means you have one correct color in the correct position.
      \n⚪ means you have one correct color in the wrong position.
    HEREDOC
  end

  def display_note
    puts <<~HEREDOC
      \n#{'Note'.underline.bold} that the clues are in no particular order, so the #{'codebreaker'.gray.bold} won't
      explicitly know which colors have been guessed correctly via the clues alone.
    HEREDOC
  end

  def display_last_example
    puts <<~HEREDOC
      \nCode and clues example:
      \n#{'  2  '.bg_green} #{'  4  '.bg_blue} #{'  6  '.bg_cyan} #{'  2  '.bg_green}   Clues: 🔴 ⚪ ⚪
    HEREDOC
  end

  def display_gameplay_choice_question
    puts <<~HEREDOC
      \nWould you like to be the codebreaker or the codemaker?
      (Type in 1 to be the codebreaker and 2 to be the codemaker)
    HEREDOC
  end

  def display_starting_of_game
    puts "\nThe computer has made the code. Good luck!"
  end

  def display_prompt_for_guess(turn)
    puts "\n#{'Turn'.bold} #{(turn + 1).to_s.bold}: Type in four numbers (between 1 and 6, inclusive) to guess the code:"
  end

  def display_prompt_for_turn(turn)
    puts "\n#{'Turn'.bold} #{(turn + 1).to_s.bold}:"
  end

  def display_prompt_for_making_code
    puts "\nPlease make the code using four numbers (between 1 and 6, inclusive)."
  end

  def display_warning(warning_code)
    puts "Your #{warning_code} should only be 4 digits between 1 and 6, inclusive.".red
  end

  def display_valid_choice_warning
    puts 'Please enter a valid choice.'.red
  end

  def display_winning_message(codebreaker_mode)
    if codebreaker_mode
      puts "\nYou broke the code. Congratulations!"
    else
      puts "\nThe computer broke the code!"
    end
  end

  def display_game_over_message
    puts "\nGame is over. Here is the code you were trying to break:"
    @code = []
    match_colors(@computer.code, @code)
    puts "\n#{@code.join(' ')}"
  end

  def display_round_output(colors, clues)
    puts "\n#{colors.join(' ')}  Clues: #{clues.shuffle.join(' ')}"
  end

  def display_computer_starting_game
    puts "\nThe computer will start guessing the code you made."
  end
end
