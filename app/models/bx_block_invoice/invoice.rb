module BxBlockInvoice
	class Invoice < ApplicationRecord
		self.table_name = :invoices
	    belongs_to :booking, class_name: 'BxBlockBooking::Booking', foreign_key: 'booking_id'
	end
end
