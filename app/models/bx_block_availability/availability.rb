module BxBlockAvailability
  class Availability < ApplicationRecord
    self.table_name = :availabilities
    belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'account_id'
    validates :start_time,:end_time, presence: true
  end
end
