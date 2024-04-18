module AccountBlock
  class AccountSerializer < ActiveModel::Serializer
    attributes *[
               :id, 
               :first_name, 
               :last_name, 
               :full_phone_number, 
               :country_code, 
               :phone_number, 
               :email,   
               :user_name, 
               :user_type, 
               :role,
               :otp,
               :start_time,
               :end_time,
               :created_at, 
               :updated_at
              ]
  end
end
