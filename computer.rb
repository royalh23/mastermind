class Computer
  attr_reader :code

  def initialize
    @code = nil
  end

  def make_code
    @code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end

  def make_guess(number)
    @code = [number, number, number, number]
  end
end
