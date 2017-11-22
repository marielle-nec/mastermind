class Mastermind

  attr_reader :turns

  def initialize(turns = 6, solution)
    @starting_number_of_turns = turns
    @solution = solution
    @turns = []
  end

  def game_over?
    turns_left == 0 || won?
  end

  def take_turn(guess)
    @turns << Turn.new(guess, @solution.response(guess))
  end

  def turns_left
    @starting_number_of_turns - @turns.length
  end

  def won?
    @turns.any? { |turn| turn.guess == @solution.solution }
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

    guess.zip(solution).each do |g, s|
      if g == s
        black_pegs += 1
      else
        unmatched_guess_items << g
        unmatched_solution_items << s
      end
    end

    unmatched_guess_items.each do |g|
      if unmatched_solution_items.include?(g)
        unmatched_solution_items.delete_at(unmatched_solution_items.index(g))
        white_pegs += 1
      end
    end

    Response.new(white_pegs, black_pegs)
  end

end
