# app/serializers/bx_block_service/service_serializer.rb
module BxBlockService
  class ServiceSerializer < ActiveModel::Serializer
    attributes *[:id, 
    :account_id, 
    :service_department, 
    :description, 
    :start_time, 
    :end_time, 
    :status, 
    :full_name, 
    :address, 
    :price,
    :discount_percentage,
    :latitude, 
    :longitude, 
    :created_at, 
    :updated_at
  ]
  end
end
