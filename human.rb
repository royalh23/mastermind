class Human
  attr_reader :code

  def initialize
    @code = nil
  end

  def make_code
    @code = gets.chomp
  end
end
