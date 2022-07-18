# frozen_string_literal: true

require "rails"
require "active_support/all"

require "decidim/core"

module Decidim
  module Referral
    # This is the engine that runs on the public interface of referral.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Referral

      routes do
        resources :referrals, only: [:index], as: "user_referrals"
      end

      initializer "decidim_referral.middleware" do |app|
        app.config.middleware.insert_after Warden::Manager, Decidim::Referral::Middleware::Sticky
      end

      config.to_prepare do
        Decidim::User.include(Decidim::Referral::UserOverride)
        Decidim::WelcomeNotificationEvent.include(Decidim::Referral::WelcomeNotificationEvent)
        Decidim::CreateRegistration.include(Decidim::Referral::RegistrationOverrides)
        routing = Decidim::Referral::Engine.routes.url_helpers
        Decidim.menu :user_menu do |menu|
          menu.item(
            t("user_referrals", scope: "layouts.decidim.user_profile"),
            routing.user_referrals_path,
            position: 2
          )
        end
      end
    end
  end
end
