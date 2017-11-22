require_relative "../mastermind"



shared_examples "a correct response" do |white_pegs, black_pegs|
  it "has #{white_pegs} white pegs" do
    expect(response.number_of_white_pegs).to eq(white_pegs)
  end

  it "has #{black_pegs} black pegs" do
    expect(response.number_of_black_pegs).to eq(black_pegs)
  end
end

describe Mastermind do
  let(:solution) { [1,2,3,4] }
  let(:incorrect_test_guess) { [1,1,4,3] }
  let(:model) { Mastermind.new(6, solution) }

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

  describe "#turns" do
    subject(:turns){ model.turns }

    context "when no turns have been made" do
      it { is_expected.to be_empty }
    end

    context "when a turn has been made" do
      before { model.take_turn([1,2,3,4]) }
      it "should have return one turn" do
        expect(subject.length).to eq(1)
      end

      describe "the returned turn" do
        subject(:turn) { turns.first }

        it "its guess should be the same as the input" do
          expect(subject.guess).to eq([1,2,3,4])
        end

        it_behaves_like "a correct response", 0, 4 do
          let(:response) { turn.response }
        end
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

describe Solution do
  let(:solution) { Solution.new([1,2,3,4]) }

  def count_white_pegs(response)
    response.count{ |item| item == white_peg }
  end

  def count_black_pegs(response)
    response.count{ |item| item == black_peg }
  end

  describe "#response" do
    subject(:response) { solution.response(guess) }

    context "when the guess only contains one correctly colored peg" do
      let(:guess) { [2,5,5,5] }
      include_examples "a correct response", 1, 0
    end

    context "when the guess only contains one correctly coloured and placed peg" do
      let(:guess) { [1,5,5,5] }
      include_examples "a correct response", 0, 1
    end
  end
end
