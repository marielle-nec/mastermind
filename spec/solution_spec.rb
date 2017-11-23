require_relative "../mastermind"

shared_examples "a correct response" do |white_pegs, black_pegs|
  it "has #{white_pegs} white pegs" do
    expect(response.white_pegs).to eq(white_pegs)
  end

  it "has #{black_pegs} black pegs" do
    expect(response.black_pegs).to eq(black_pegs)
  end
end

describe Solution do
  def count_white_pegs(response)
    response.count{ |item| item == white_peg }
  end

  def count_black_pegs(response)
    response.count{ |item| item == black_peg }
  end

  describe "#response" do
    subject(:response) { solution.response(guess) }

    describe "when the solution has unique elements" do
      let(:solution) { Solution.new([1,2,3,4]) }

      context "when the guess only contains one correctly colored peg" do
        let(:guess) { [2,5,5,5] }
        include_examples "a correct response", 1, 0
      end

      context "when the guess only contains one correctly coloured and placed peg" do
        let(:guess) { [1,5,5,5] }
        include_examples "a correct response", 0, 1
      end

      context "when the guess contains 3 correctly coloured and placed pegs" do
        let(:guess) { [1,2,3,5] }
        include_examples "a correct response", 0, 3
      end

      context "when the guess contains 2 correct colours but no correct placements" do
        let(:guess) { [5,3,5,2] }
        include_examples "a correct response", 2, 0
      end
    end

    describe "when the solution contains duplicate elements" do
      let(:solution) { Solution.new([6,1,1,6]) }

      context "when the guess only contains one correctly colored peg" do
        let(:guess) { [1,5,5,5] }
        include_examples "a correct response", 1, 0
      end

      context "when the guess only contains one correctly coloured and placed peg" do
        let(:guess) { [6,5,5,5] }
        include_examples "a correct response", 0, 1
      end

      context "when the guess contains 3 correctly coloured and placed pegs" do
        let(:guess) { [1,1,1,6] }
        include_examples "a correct response", 0, 3
      end

      context "when the guess contains 3 correctly coloured but not placed pegs" do
        let(:guess) { [5,6,6,1] }
        include_examples "a correct response", 3, 0
      end
    end
  end
end
