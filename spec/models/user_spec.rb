RSpec.describe User, type: :model do
  describe "factory_bot" do
    it "can build model" do
      expect(build(:user).save!).to be_truthy
    end
  end
end
