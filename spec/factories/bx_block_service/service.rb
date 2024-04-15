FactoryBot.define do
  factory :service, class: 'BxBlockService::Service' do
    service_department { "bathroom_renovation" }
    price { 15000.00 }
    discount_percentage { 15 }
    description { "bathroom_renovation service" }
    start_time { "2024-04-01T12:00:00Z" }
    end_time { "2024-04-01T14:00:00Z" }
    status { "un_assigned" }
    full_name { "Komal singh" }
    address { "Indore Vijay Nagar" }
    account_id { 1 } 
  end
end
