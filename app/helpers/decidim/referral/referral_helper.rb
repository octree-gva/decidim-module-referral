# frozen_string_literal: true

module Decidim::Referral
  module ReferralHelper
    def referal_link
      decidim.root_url(
        host: current_organization.host,
        invite: current_user.referral_token
      )
    end
    def referral_scoring
      referrals.select(:id, :nickname, :confirmed_at)
    end
    def referral_scoring_count
      referrals.count
    end
    def referrals
      Decidim::User.where(
        invited_by_id: current_user.id
      ).where.not(
        confirmed_at: nil
      )
    end
    def decidim
      Decidim::Core::Engine.routes.url_helpers
    end
  end
end
