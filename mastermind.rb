require './colors'

class Mastermind
  def run_game
    while true
      puts "\nWelcome to Mastermind!".bold
      puts "\nIn this game, you will be playing against the computer as one " \
            'of the following:'
      puts "\n\t- The #{'codebreaker'.gray.bold}"
      puts "\t- The #{'codemaker'.gray.bold}"
      puts "\nThe #{'codemaker'.gray.bold} makes the code, which is a "
      puts 'sequence of four colors chosen from the following:'
      puts "\n#{'  1  '.bg_red} #{'  2  '.bg_green} #{'  3  '.bg_brown} #{'  4  '.bg_blue} #{'  5  '.bg_magenta} #{'  6  '.bg_cyan}"
      puts "\nAn example of a code:"
      puts "\n#{'  2  '.bg_green} #{'  4  '.bg_blue} #{'  6  '.bg_cyan} #{'  2  '.bg_green}"

      puts "\nAs you can see, there can be more than one of the same color."
      puts "The #{'codebreaker'.gray.bold} attempts to guess the code in 12 " \
          'or fewer turns.'
      puts 'After each guess, clues will be given in the form of colors.'
      puts "\n🔴 means you have one correct color in the correct position."
      puts "\n⚪ means you have one correct color in the wrong position."
      puts "\n#{'Note'.underline.bold} that the clues are in no particular " \
          "order, so the #{'codebreaker'.gray.bold} won't"
      puts 'explicitly know which colors have been guessed correctly via the' \
          ' clues alone.'
      puts "\nCode and clues example:"
      puts "\n#{'  2  '.bg_green} #{'  4  '.bg_blue} #{'  6  '.bg_cyan} #{'  2  '.bg_green}" \
           '   Clues: 🔴 ⚪ ⚪'

      # Computer randomly selects a 4-color code
      code = Computer.new
      break
    end
  end
end

class Human
end

class Computer
end

new_game = Mastermind.new
new_game.run_game
