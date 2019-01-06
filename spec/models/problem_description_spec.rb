RSpec.describe ProblemDescription, type: :model do
  describe "factory_bot" do
    it "can build model" do
      expect(build(:problem_description).save!).to be_truthy
    end
  end
end
