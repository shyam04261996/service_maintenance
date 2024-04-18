FactoryBot.define do
  factory :booking, class: 'BxBlockBooking::Booking' do
    service_id { FactoryBot.create(:service).id }
    client_account_id {FactoryBot.create(:accounts).id}
    full_name {"duumy"}
    mobile_number {"+91-9876500000"}
    start_time {"2023-04-17T10:00:00Z"}
    end_time {"2023-04-17T09:00:00Z"}
    address {"DNS Hospital Indore"}
    service_department { "bathroom_renovation" }
    description {"vishes Hospital door exchange and window"}
    status {"Pending"}
  end
end
