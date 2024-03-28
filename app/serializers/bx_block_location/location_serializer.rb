module BxBlockLocation
  class LocationSerializer < ActiveModel::Serializer
    attributes *[
               :id,
               :address,
               :city,
               :state,
               :country,
               :longitude,
               :latitude,
               :employee_account_id,
               :client_account_id,
               :description,
               :town,
               :postal_code,
               :service_id,
               :created_at,
               :updated_at
              ]
  end
end
