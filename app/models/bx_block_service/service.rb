module BxBlockService
	class Service < ApplicationRecord
  	
  	belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'account_id'
    has_many :bookings, class_name: 'BxBlockBooking::Booking', foreign_key: 'service_id'	end	
end

