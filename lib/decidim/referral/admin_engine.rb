# frozen_string_literal: true

module Decidim
  module Referral
    # This is the engine that runs on the public interface of `Referral`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Referral::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :referral do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "referral#index"
      end

      def load_seed
        nil
      end
    end
  end
end
