# frozen_string_literal: true

require "decidim/referral/admin"
require "decidim/referral/engine"
require "decidim/referral/admin_engine"
require "decidim/referral/middleware/sticky"


module Decidim
  # This namespace holds the logic of the `Referral` component. This component
  # allows users to create referral in a participatory space.
  module Referral
  end
end

Decidim.register_global_engine(
  :decidim_referral,
  ::Decidim::Referral::Engine,
  at: "/referrals"
)
