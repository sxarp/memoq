RSpec.describe ProblemRevisionQuestion, type: :model do
  describe "factory_bot" do
    it "can build model" do
      problem = create(:problem, user: create(:user))
      problem_description = create(:problem_description)
      problem_revision = create(:problem_revision, problem: problem, problem_description: problem_description)
      question = create(:question)

      expect(build(:problem_revision_question,
                   problem_revision: problem_revision,
                   question: question).save!).to be_truthy
    end
  end
end
