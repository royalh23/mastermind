require_relative 'colors'
require_relative 'game'
require_relative 'computer'
require_relative 'human'

def play_game
  mastermind = Game.new
  mastermind.play
  repeat_game
end

def repeat_game
  puts "\nWould you like to play again? (y/n)"
  answer = gets.chomp.downcase
  if answer == 'y' || answer == 'yes'
    play_game
  else
    puts "\nThanks for playing :)"
  end
end

play_game
