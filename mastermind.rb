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

Solution = Struct.new(:solution) do
  def response(guess)
    unmatched_solution_items = []
    unmatched_guess_items = []
    black_pegs = 0
    white_pegs = 0


    guess.zip(solution).each do |g, actual|
      if g == actual
        black_pegs += 1
      else
        if unmatched_solution_items.include?(g)
          unmatched_solution_items.delete_at(unmatched_solution_items.index(g))
          white_pegs += 1
        else
          unmatched_guess_items << g
        end

        if unmatched_guess_items.include?(actual)
          unmatched_guess_items.delete_at(unmatched_guess_items.index(actual))
          white_pegs += 1
        else
          unmatched_solution_items << actual
        end
      end
    end
     Response.new(white_pegs, black_pegs)
  end
end
