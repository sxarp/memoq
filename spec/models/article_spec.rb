require "rails_helper"

RSpec.describe Article, type: :model do
  context "try spec tests" do
    it "test" do
      article = Article.create!
      expect(article.id).to be_truthy
    end
  end
end
