class Mastermind

  attr_reader :turns

  def initialize(turns = 6, solution)
    @starting_number_of_turns = turns
    @solution = solution
    @won = false
    @turns = []
  end

  def game_over?
      @starting_number_of_turns == 0 || @won
  end

  def take_turn(guess)
    @starting_number_of_turns -= 1
    @won = guess == @solution
    @turns << Turn.new(guess, Response.new(0, 4))
  end

end

Turn = Struct.new(:guess, :response)


Response = Struct.new(:number_of_white_pegs, :number_of_black_pegs)
