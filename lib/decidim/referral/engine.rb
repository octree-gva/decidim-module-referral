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
        resources :referrals, only: [:index]
      end

      initializer "decidim_referral.assets" do |app|
        app.config.assets.precompile += %w[decidim_referral_manifest.js decidim_referral_manifest.css]
      end
      initializer "decidim_referral.middleware" do |app|
        app.config.middleware.insert_after Warden::Manager, Decidim::Referral::Middleware::Sticky
      end
    end
  end
end
