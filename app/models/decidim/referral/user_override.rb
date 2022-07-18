# frozen_string_literal: true

module Decidim
  module Referral
    module UserOverride
      extend ActiveSupport::Concern

      included do
        before_create :set_referral_token!
        def set_referral_token!
          self.referral_token = SecureRandom.urlsafe_base64(48).tr("lIO0", "sxyz")
        end
      end
    end
  end
end
