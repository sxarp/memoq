require "rails_helper"
require "redis_helper"

class CurrentContextController < ActionController::Base
  include CurrentContext
end

describe CurrentContextController, type: :controller do
  controller(CurrentContextController) do
    def test_current_user_id
      @current_user_id = current_user_id

      render_something
    end

    private

      def render_something
        render plain: "custom called"
      end
  end

  controller_name = "current_context"

  describe "#current_user_id" do
    subject { get :test_current_user_id }

    action_for_test = "test_current_user_id"

    # Draw custom routes.
    # see https://relishapp.com/rspec/rspec-rails/docs/controller-specs/anonymous-controller#draw-custom-routes-for-anonymous-controllers
    before { routes.draw { get action_for_test => "#{controller_name}##{action_for_test}" } }

    context "when session[:_current_user_id] is NOT nil" do
      before { session[:_current_user_id] = current_user_id }
      let(:current_user_id) { 43 }

      it "can fetch current_user_id" do
        subject
        expect(assigns[:current_user_id]).to eq(current_user_id)
      end
    end

    context "when session[:_current_user_id] is nil" do
      it "can NOT fetch current_user_id" do
        subject
        expect(assigns[:current_user_id]).to be_nil
      end
    end
  end
end
