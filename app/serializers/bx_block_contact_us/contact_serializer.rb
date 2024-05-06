module BxBlockContactUs
  class ContactSerializer < ActiveModel::Serializer
    attributes *[
     :name, 
     :email,
     :message,
     :created_at, 
     :updated_at
    ]
  end
end
