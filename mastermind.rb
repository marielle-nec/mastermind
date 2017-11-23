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
    guess.zip(solution).count { |guess_item, solution_item| guess_item == solution_item }
  end

  def calculate_number_of_white_pegs(solution, guess)
    total_matches(solution, guess) - calculate_number_of_black_pegs(solution, guess)
  end

  private

  def total_matches(solution, guess)
    guess.uniq.sum do |guess_item|
      guess_occurences = guess.count { |item| item == guess_item }
      solution_item_count = solution.count { |item| item == guess_item }
      [guess_occurences, solution_item_count].min
    end
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
