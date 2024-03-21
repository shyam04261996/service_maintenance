class AddOtpAndOtpExpiryToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :otp, :string
    add_column :accounts, :otp_expiry, :datetime
  end
end
