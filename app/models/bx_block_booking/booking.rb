module BxBlockBooking
  class Booking < ApplicationRecord
    self.table_name = :bookings
    belongs_to :service, class_name: 'BxBlockService::Service', foreign_key: 'service_id'
    belongs_to :client, class_name: 'AccountBlock::Account', foreign_key: 'client_account_id'
    has_one :invoice, class_name: 'BxBlockInvoice::Invoice', foreign_key: 'booking_id'

    validates :status, inclusion: { in: %w(Pending Confirmed Cancelled In_progress Complete) }

    after_commit :price_calculation, on: :create

    private

    def price_calculation 
      update_columns(price: service.price, discount_amount: calculate_discounted_price, total_amount: calculate_total_amount)
    end

    def calculate_discounted_price
      service.price * service.discount_percentage / 100
    end

    def calculate_total_amount
      service.price - calculate_discounted_price
    end
  end
end
