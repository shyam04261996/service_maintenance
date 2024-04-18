require 'phonelib'
module AccountBlock
 class Account < ApplicationRecord
    self.table_name = :accounts
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    before_validation :parse_full_phone_number
    validate :valid_phone_number
    validates :role, presence: true, inclusion: { in: %w(User Employee Client) }
    
    has_many :services, class_name: 'BxBlockService::Service', foreign_key: 'account_id', dependent: :destroy
    has_many :bookings, class_name: 'BxBlockBooking::Booking', foreign_key: 'client_account_id',  dependent: :destroy
    # has_many :locations, class_name: 'BxBlockLocation::Location', foreign_key: 'account_id', dependent: :destroy
    has_many :availabilities, class_name: 'BxBlockAvailability::Availability', foreign_key: 'account_id', dependent: :destroy


    private
    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def valid_phone_number
      unless Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number, "Invalid or Unrecognized Phone Number")
      end
    end
  end
end
