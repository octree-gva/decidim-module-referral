require "spec_helper"

module Decidim::Referral
  RSpec.describe "Middleware::Sticky", type: :request do
    subject { response.body }
    let(:organization) { create :organization }
    let(:headers) {  { "HOST" => organization.host } }
    let(:password) { Faker::Internet.password(min_length: 12) }

    def register(user)
      register_path = Decidim::Core::Engine.routes.url_helpers.user_registration_path
      payload = {
          tos_agreement: "1",
          email: user.email,
          name: user.name,
          password: password,
          password_confirmation: password,
          nickname: user.nickname,
          newsletter: "0", organization_id: organization.id
          }
      post(
        register_path,
        params: { user: payload, },
        headers: headers
      )
    end

    def visit
      get(
        request_path,
        params: { invite: "6Ft3VJWSk4KzMPGRv10VmkKQiVElH1alEK" },
        headers: headers
      )
    end

    describe "Visiting the homepage with an invite token" do
      let(:request_path) { decidim.root_path }
      describe ", as authenticate user" do
        let(:user) { create :user, :confirmed, password: password, password_confirmation: password, organization: organization }

        it "doesn't stick the invite" do
          sign_in(user)
          visit
          expect(request.cookie_jar.encrypted["decidim_referral"]).to be(nil)
        end
      end

      describe ", as unauthenticate user" do
        it "sticks the invite in a encrypted cookie" do
          visit
          expect(request.cookie_jar.encrypted["decidim_referral"]).to eq("6Ft3VJWSk4KzMPGRv10VmkKQiVElH1alEK")
        end
      end
    end
    describe "Upon registration" do
      it "creates a uniq invitation token" do
        user = Decidim::User.new(
          email: "test@example.com",
          nickname: "itsatests",
          name: "John doe",
        )
        response = register user
        created_user = Decidim::User.last
        expect(created_user.referral_token.length).to be > 16
      end
    end
  end
end
