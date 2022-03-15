class Computer
  attr_reader :code

  def initialize
    @code = nil
  end

  def make_code
    @code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end

  def make_guess(number1, number2, number3, number4)
    @code = [number1, number2, number3, number4]
  end
end
