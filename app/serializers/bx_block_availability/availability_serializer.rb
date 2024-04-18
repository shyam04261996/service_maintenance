module BxBlockAvailability
  class AvailabilitySerializer < ActiveModel::Serializer
      attributes *[
        :id, 
        :start_time, 
        :end_time, 
        :remark,
        :description,
        :account_id, 
        :created_at, 
        :updated_at
      ]
    end
end
