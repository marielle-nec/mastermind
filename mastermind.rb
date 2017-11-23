class Mastermind
  attr_reader :turns, :solution

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

class Turn
  attr_reader :guess, :response

  def initialize(guess, response)
    @guess = guess
    @response = response
  end
end

class Response

  attr_reader :white_pegs, :black_pegs

  def initialize(solution, guess)
    @white_pegs = calculate_number_of_white_pegs(solution, guess)
    @black_pegs = calculate_number_of_black_pegs(solution, guess)

  end

  def calculate_number_of_black_pegs(solution, guess)
    guess.zip(solution).select { |guess_item, solution_item| guess_item == solution_item }.length
  end

  def calculate_number_of_white_pegs(solution, guess)
    unmatched_guess_items = []
    unmatched_solution_items = []
    white_pegs = 0

    guess.zip(solution)
    .reject { |guess_item, solution_item| guess_item == solution_item }
    .each do |guess_item, solution_item|
      unmatched_guess_items << guess_item
      unmatched_solution_items << solution_item
    end

    unmatched_guess_items.each do |guess_item|
      if unmatched_solution_items.include?(guess_item)
        unmatched_solution_items.delete_at(unmatched_solution_items.index(guess_item))
        white_pegs += 1
      end
    end

    white_pegs
  end
end

class Solution
  attr_reader :solution

  def initialize(solution)
    @solution = solution
  end

  def response(guess)
    Response.new(solution, guess)
  end
end
