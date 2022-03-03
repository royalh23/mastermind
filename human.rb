class Human
  attr_reader :guess
  
  def initialize
    @guess = nil
  end

  def make_guess
    @guess = gets.chomp
  end
end
