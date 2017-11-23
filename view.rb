class View
  INPUT_VALIDATION_REGEX = /^[1-6]{4}$/

  def initialize(model)
    @model = model
  end

  def display_welcome
    puts "Welcome to GAMELAND"
  end

  def display_turns
    puts ""
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
end
