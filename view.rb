class View
  INPUT_VALIDATION_REGEX = /^[1-6]{4}$/

  def initialize(model)
    @model = model
  end

  def display_welcome
    puts "Welcome to Mastermind!"
  end

  def display_turns
    @model.turns.each { |turn| puts turn_to_string(turn) }
  end

  def ask_for_guess
    loop do
      input = $stdin.gets.strip

      break string_to_guess(input) if user_input_valid?(input)

      puts "Invalid input, try again"
    end
  end

  def turn_to_string(turn)
    turn.guess.join + " - " + [turn.response.white_pegs, turn.response.black_pegs].join
  end

  def display_solution
    puts solution_to_string(@model.solution)
  end

  def solution_to_string(solution)
    solution.solution.join
  end

  def user_input_valid?(guess)
    guess.match(INPUT_VALIDATION_REGEX) != nil
  end

  def string_to_guess(string)
    string.chars.map { |char| char.to_i }
  end
end
