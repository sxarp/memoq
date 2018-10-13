require "rails_helper"

RSpec.describe "Simple", type: :request do
  context "try spec tests" do
    it "returns simple json" do
      get "/simple"
      aggregate_failures do
        expect(response.status).to be(200)
        expect(json_resp).to eq({ "id" => "1", "type" => "simple", "attributes" => { "content" => "simple" } })
      end
    end
  end
end
