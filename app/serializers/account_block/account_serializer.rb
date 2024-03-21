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
               :created_at, 
               :updated_at
              ]
  end
end
