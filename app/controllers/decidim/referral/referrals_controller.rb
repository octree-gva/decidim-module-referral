require_dependency "decidim/referral/application_controller"

module Decidim
  module Referral
    class ReferralsController < Decidim::Referral::ApplicationController
      def index
        puts "hello"
        render text: "hello"
      end
    end
  end
end
