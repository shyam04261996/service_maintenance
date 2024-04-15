module BxBlockBooking
	class Booking < ApplicationRecord
		belongs_to :service, class_name: 'BxBlockService::Service', foreign_key: 'service_id'
	    belongs_to :client, class_name: 'AccountBlock::Account', foreign_key: 'client_account_id'
	    has_one :invoice, class_name: 'BxBlockInvoice::Invoice', foreign_key: 'booking_id'

		validates :status, inclusion: { in: %w(Pending Confirmed Cancelled In_progress Complete) }
	end
end

