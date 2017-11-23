require_relative "../view"

describe View do
  describe "#user_input_valid?" do
    let
    context "(valid input) user gives four space separated numbers within a defined range" do
      expect(view.user_input_valid?("1 2 3 4").to be true)
    end

    describe "when the user gives invalid input" do
      subject(:valid?) { view.user_input_valid?(user_input) }

      context "the user gives four space separated numbers where one is above the defined range" do
        let(:user_input) { "1 3 2 9" }
        it { is_expected.to be false }
      end

      context "the user gives four space separated numbers where one is below the defined range" do
        let(:user_input) { "1 0 3 2" }
        it { is_expected.to be false }
      end

      context "the user does not give enough numbers" do
        let(:user_input) { "1 2 3" }
        it { is_expected.to be false }
      end

      # context "the user does not separate all numbers " do
      #
      # end
      #
      # context "user does not give numeric characters"
    end
  end
end
