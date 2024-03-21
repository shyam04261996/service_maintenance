module BxBlockBooking
  class BookingSerializer < ActiveModel::Serializer
    attributes *[
               :id, 
               :full_name,
               :mobile_number, 
               :client_account_id,
               :status, 
               :service_department, 
               :service_id,
               :created_at, 
               :updated_at
              ]
  end
end
