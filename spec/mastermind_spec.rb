require_relative "../mastermind"

shared_examples "check turn guess and response" do |guesses|
  guesses.each_index do |i|
    context "turn #{i+1}" do
      let(:turn) { turns[i] }
      it "has the correct guess" do
        expect(turn.guess).to eq(guesses[i])
      end

      it "has the correct response" do
        expected_response = solution.response(guesses[i])
        expect(turn.response.white_pegs).to eq(expected_response.white_pegs)
        expect(turn.response.black_pegs).to eq(expected_response.black_pegs)
      end
    end
  end
end

describe Mastermind do
  let(:solution) { Solution.new([1,2,3,4]) }
  let(:incorrect_test_guess) { [1,1,4,3] }
  let(:model) { Mastermind.new(6, solution) }

  # describe "#play" do
  #
  # end

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

      include_examples "check turn guess and response", [[1,2,3,4]]
    end

    context "when two turns have been made" do
      guesses = [[1,2,3,4], [4,3,2,1]]
      before { guesses.each { |guess| model.take_turn(guess) } }

      include_examples "check turn guess and response", guesses
    end
  end
end

describe Turn do
  let(:test_guess)    { [1,2,4,4] }
  let(:test_response) { [] }
  let(:turn)          { Turn.new(test_guess, test_response) }

  it "stores the guess it's given" do
    expect(turn.guess).to eq(test_guess)
  end

  it "stores a response it's given" do
    expect(turn.response).to eq(test_response)
  end
end
