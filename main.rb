require_relative 'colors'
require_relative 'game'

def play_game
  mastermind = Game.new
  mastermind.play
end

play_game
