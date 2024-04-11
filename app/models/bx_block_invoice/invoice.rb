module BxBlockInvoice

	class Invoice < ApplicationRecord
	    belongs_to :booking, class_name: 'BxBlockBooking::Booking', foreign_key: 'booking_id'
	end
end
