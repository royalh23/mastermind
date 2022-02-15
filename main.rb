require_relative 'colors'
require_relative 'game'
require_relative 'computer'
require_relative 'human'

def play_game
  mastermind = Game.new
  mastermind.play
end

play_game
