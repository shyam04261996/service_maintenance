module BxBlockLocation
 class Location < ApplicationRecord
    self.table_name = :locations
    geocoded_by :full_address do |obj, results|
      if geo = results.first
        obj.city = geo.city
        obj.state = geo.state
        obj.country = geo.country
        obj.latitude = geo.latitude
        obj.longitude = geo.longitude        
        obj.postal_code = geo.postal_code
      end
    end
    after_validation :geocode
    validates :address, presence: true

    belongs_to :employee_account, class_name: 'AccountBlock::Account', optional: true, foreign_key: 'employee_account_id'
    belongs_to :client_account, class_name: 'AccountBlock::Account', optional: true, foreign_key: 'client_account_id'


    def full_address
      [address, city, state, country, postal_code].compact.join(', ')
    end
 end
end
