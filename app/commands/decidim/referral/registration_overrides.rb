# frozen_string_literal: true

module Decidim::Referral::RegistrationOverrides
  extend ActiveSupport::Concern

    private
    def create_user
      puts "HERE"
      invited_by = nil
      if request.cookie_jar.encrypted["decidim_referral"]
        match = Decidim::User.where(referral_token: request.cookie_jar.encrypted["decidim_referral"])
        invited_by = match.first if match.exists?
      end
      @user = Decidim::User.create!(
        email: form.email,
        name: form.name,
        nickname: form.nickname,
        password: form.password,
        password_confirmation: form.password_confirmation,
        organization: form.current_organization,
        tos_agreement: form.tos_agreement,
        newsletter_notifications_at: form.newsletter_at,
        accepted_tos_version: form.current_organization.tos_version,
        locale: form.current_locale,
        invited_by: invited_by,
        **(Object.const_defined?("Decidim::ExtraUserFields") ? {
          extended_data: extended_data
        } : {})
      )
    end
end
