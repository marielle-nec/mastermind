require_relative "../view"

describe View do
  let(:model) { instance_double(Mastermind) }
  let(:view) { View.new(model) }

  describe "#display_welcome" do
    subject { view.display_welcome }

    it "is expected to output \"Welcome to Mastermind!\"" do
      expect { subject }.to output("Welcome to Mastermind!\n").to_stdout
    end
  end

  describe "#display_turns" do
    subject { view.display_turns }
    # context "when there are no turns" do
    #   let(:model) do
    #     instance_double(Mastermind,
    #       solution: Solution.new([1,2,3,4]),
    #       turns: []
    #     )
    #   end
    #
    #   it "is expected to output nothing" do
    #     expect { subject }.to output("").to_stdout
    #   end
    # end

    context "when 1234 has been guessed" do
      solution = Solution.new([1,2,3,4])
      let(:model) do
        instance_double(Mastermind,
          solution: solution,
          turns: [Turn.new([1,2,3,4], solution.response([1,2,3,4]))]
        )
      end

      it "is expected to output \"1234 - 0w, 4b\"" do
        expect { subject }.to output("Previous Guesses:\n1234 - 0w, 4b\n").to_stdout
      end
    end
  end

  describe "#display_game_result" do
    subject { view.display_game_result }

    context "when the user has won the game" do
      let(:model) { instance_double(Mastermind, won?: true) }

      it "is expected to output \"Congratulations, you guessed the code.\"" do
        expect { subject }.to output("Congratulations, you guessed the code.\n").to_stdout
      end
    end

    # context "when the user has lost the game" do
    #   let(:model) { instance_double(Mastermind, won?: false) }
    #
    #   it "is expected to output \"You failed to crack the code, which was 1234\"" do
    #     expect { subject }.to output("You failed to crack the code, which was 1234\n").to_stdout
    #   end
    # end
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

  describe "#ask_for_guess" do
    subject(:input) { view.ask_for_guess }

    context "when the user inputs \"1234\"" do
      it "should correctly parse it to [1,2,3,4]" do
        allow($stdin).to receive(:gets).and_return("1234\n")
        expect(subject).to eq([1,2,3,4])
      end
    end

    context "when the user inputs \"1230\" and then \"1234\"" do
      it "should display an error message and then correctly parse it to [1,2,3,4]" do
        allow($stdin).to receive(:gets).and_return("1230\n", "1234\n")
        expect { subject }.to output("Invalid input, try again\n").to_stdout
        expect(subject).to eq([1,2,3,4])
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
