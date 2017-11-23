require_relative 'mastermind'
require_relative 'view'

class Controller

  def initialize
    @mastermind = Mastermind.new(6, Solution.new([1,2,3,4]))
    @view = View.new(@mastermind)
  end

  def play
    @view.display_welcome
    while !@mastermind.game_over?

      guess = @view.ask_for_guess
      @mastermind.take_turn(guess)
      @view.display_turns

    end
  end
end


Controller.new.play
