RSpec.describe ProblemRevision, type: :model do
  describe "factory_bot" do
    it "can build model" do
      problem = create(:problem, user: create(:user))
      problem_description = create(:problem_description)
      expect(build(:problem_revision, problem: problem, problem_description: problem_description).save!).to be_truthy
    end
  end
end
