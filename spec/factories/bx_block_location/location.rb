FactoryBot.define do
  factory :location, class: 'BxBlockLocation::Location' do
    client_account_id {FactoryBot.create(:accounts).id}
    employee_account_id {FactoryBot.create(:accounts).id}
    address {"Ujjain"}
    city {"Ujjain"}
    state {"Madhya Pradesh"}
    country {"India"}
    description {"location dummy comments"}
    postal_code {"456001"}
  end
end
