module Decidim
  module Referral
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    def referral_invite(user)
      moderated? and user.is_a?(User) and user.id == self.user_id
    end

    module ClassMethods
    end
  end
end
