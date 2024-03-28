module BxBlockLocation
 class Location < ApplicationRecord
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

    def full_address
      [address, city, state, country, postal_code].compact.join(', ')
    end
 end
end
