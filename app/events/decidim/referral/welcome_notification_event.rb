# frozen_string_literal: true

require "mustache"

module Decidim::Referral::WelcomeNotificationEvent
  extend ActiveSupport::Concern

  included do
    def interpolate(template)
      Mustache.render(
        template.to_s,
        organization: organization.name,
        name: user.name,
        help_url: url_helpers.pages_url(host: organization.host),
        badges_url: url_helpers.gamification_badges_url(host: organization.host),
        referral_url: url_helpers.root_url(host: organization.host, invite: user.referral_token)
      ).html_safe
    end
  end
end
