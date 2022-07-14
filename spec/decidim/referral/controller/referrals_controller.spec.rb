require "spec_helper"

module Decidim::Referral
  describe ReferralsController, type: :controller do
    routes { Decidim::Referral::Engine.routes }

    let(:user) { create(:user, :confirmed) }

    before do
      request.env["decidim.current_organization"] = user.organization
      sign_in user, scope: :user
    end


    describe "GET index" do
      it "displays the index" do
        get :index
      end
      it "redirects visitors to login" do
        # get :index
      end
    end

  end
end
