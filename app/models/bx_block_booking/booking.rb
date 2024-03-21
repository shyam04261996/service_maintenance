module BxBlockBooking
	class Booking < ApplicationRecord
		belongs_to :service, class_name: 'BxBlockService::Service', foreign_key: 'service_id'
	    belongs_to :client, class_name: 'AccountBlock::Account', foreign_key: 'client_account_id'
	end
end

