class Computer
  attr_reader :code

  def initialize
    @code = nil
  end

  def make_code
    @code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end

  def make_guess(computer_guess)
    @code = computer_guess
  end
end
