# frozen_string_literal: true

module Decidim
  module Referral
    module Middleware
      class Sticky
        def initialize(app)
          @app = app
        end

        def call(env)
          request = ActionDispatch::Request.new(env)
          if request.cookie_jar.encrypted["decidim_referral"]
          end
          if request.method === "GET" && request.params.include?("invite") then
            current_user = env["warden"].user(:user)
            request.cookie_jar.encrypted["decidim_referral"] = request.params["invite"] unless current_user.present?
          end
          @app.call(env)
        end
      end
    end
  end
end
