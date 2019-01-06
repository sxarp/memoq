RSpec.describe Problem, type: :model do
  describe "factory_bot" do
    it "can build model" do
      expect(build(:problem, user: create(:user)).save!).to be_truthy
    end
  end
end
