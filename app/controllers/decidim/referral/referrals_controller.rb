# frozen_string_literal: true

require_dependency "decidim/referral/application_controller"

module Decidim
  module Referral
    class ReferralsController < Decidim::Referral::ApplicationController
      include Decidim::UserProfile
      helper Decidim::Referral::ReferralHelper

      before_action :authenticate_user!
      def index; end
    end
  end
end
