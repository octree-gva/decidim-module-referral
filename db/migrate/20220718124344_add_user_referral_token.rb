class AddUserReferralToken < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :referral_token, :string

  end
end
