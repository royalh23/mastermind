require_relative 'display'

class Game
  include Display

  def initialize
    @computer = Computer.new
    @human = Human.new
  end

  def play
    explain_game

    # Computer randomly selects a 4-color code
    @computer.make_code

    puts "\nThe computer has made the code. Good luck!"
  end
end
