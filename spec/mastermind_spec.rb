require_relative "../mastermind"


# shared_example "response is correct" do |white_pegs, black_pegs|

describe Mastermind do
  let(:solution) { [1,2,3,4] }
  let(:incorrect_test_guess) { [1,1,4,3] }
  let(:model) { Mastermind.new(6, solution) }

  def count_white_pegs(response)
    response.count{ |item| item == white_peg }
  end

  def count_black_pegs(response)
    response.count{ |item| item == black_peg }
  end

  describe "#game_over?" do
    subject { model.game_over? }

    context "when the codebreaker has no turns left" do
      before { (1..6).each { model.take_turn([1,2,3,3]) } }
      it     { is_expected.to be true }
    end

    context "when the codebreaker has turns left" do
      it { is_expected.to be false }
    end

    context "when the user has taken a turn but has not guessed the solution" do
      before { model.take_turn([1,2,3,3]) }
      it     { is_expected.to be false }
    end

    context "when the user has guessed the solution correctly" do
      before { model.take_turn([1,2,3,4]) }
      it     { is_expected.to be true }
    end
  end

  # describe "#turns" do
  #   subject(:turns){ model.turns }
  #
  #   context "when no turns have been made" do
  #     it { is_expected.to be_empty }
  #   end
  #
  #   context "when a turn has been made" do
  #     before { model.take_turn([1,2,3,4]) }
  #     it "should have return one turn" do
  #       expect(subject.length).to eq(1)
  #     end
  #
  #     describe "the returned turn" do
  #       subject(:turn) { turns.first }
  #
  #       it "its guess should be the same as the input" do
  #         expect(subject.guess).to eq([1,2,3,4])
  #       end
  #
  #       describe "the response" do
  #         subject { turn.response }
  #
  #         it "should have 0 white pegs" do
  #           expect(subject.number_of_white_pegs).to eq(0)
  #         end
  #
  #         it "should have 4 black pegs" do
  #           expect(subject.number_of_black_pegs)
  #         end
  #       end
  #     end
  #   end
  # end

  describe "#generate_response" do
    subject(:response) { model.generate_response(guess) }

    # context "when a fully correct guess is given (all numbers in solution guessed in correct order), the response reflects this" do
    #
    # end
    context "when a guess contains one number included in the solution in the same place" do
      it "the response contains one black_peg" do
        let(:incorrect_test_guess) { [1,5,6,9] }
        expect                     { count_black_pegs(response).to eq(1) }
      end
    end
  end
end

# describe Turn do
#   let(:test_guess)    { [1,2,4,4] }
#   let(:test_response) { [] }
#   let(:turn)          { Turn.new(test_guess, test_response) }
#
#   it "stores the guess it's given" do
#     expect(turn.guess).to eq(test_guess)
#   end
#
#   it "stores a response it's given" do
#     expect(turn.response).to eq(test_response)
#   end
# end
