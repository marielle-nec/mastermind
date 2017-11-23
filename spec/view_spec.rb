require_relative "../view"

describe View do
  let(:model) { instance_double(Mastermind) }
  let(:view) { View.new(model) }

  describe "#display_welcome" do
    subject { view.display_welcome }

    it "is expected to output \"Welcome to GAMELAND\"" do
      expect { subject }.to output("Welcome to GAMELAND\n").to_stdout
    end
  end

  describe "#display_turns" do
    subject { view.display_turns }
    context "when there are no turns" do
      let(:model) do
        instance_double(Mastermind,
          solution: Solution.new([1,2,3,4]),
          turns: []
        )
      end

      it "is expected to output nothing" do
        expect { subject }.to output("\n").to_stdout
      end
    end
  end

  describe "#display_solution" do
    subject { view.display_solution }
    context "when the solution is 1234" do
      let(:model) do
        instance_double(Mastermind,
          solution: Solution.new([1,2,3,4])
        )
      end

      it "is expected to output \"1234\"" do
        expect { subject }.to output("1234\n").to_stdout
      end
    end
  end

  describe "#user_input_valid?" do
    subject(:valid?) { view.user_input_valid?(user_input) }

    context "(valid input) user gives four non separated numbers within a defined range" do
      let(:user_input) { "1234" }
      it { is_expected.to be true }
    end

    describe "when the user gives invalid input" do
      context "the user gives four non separated numbers where one is above the defined range" do
        let(:user_input) { "1329" }
        it { is_expected.to be false }
      end

      context "the user gives four non separated numbers where one is below the defined range" do
        let(:user_input) { "1032" }
        it { is_expected.to be false }
      end

      context "the user does not give enough numbers" do
        let(:user_input) { "123" }
        it { is_expected.to be false }
      end

      context "user enters too many numbers" do
        let(:user_input) { "123456" }
        it { is_expected.to be false }
      end

      context "the user's input contains alphabetic characters" do
        let(:user_input) { "123a" }
        it { is_expected.to be false }
      end

      context "the user's input contains punctuation" do
        let(:user_input) { "[1, 2, 3, 4]" }
        it { is_expected.to be false }
      end
    end
  end
end
