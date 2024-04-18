FactoryBot.define do
  factory :availability, class: 'BxBlockAvailability::Availability' do
    start_time{"10:00 AM 18/04/2024"}
    end_time{"06:00 PM 18/04/2024"}
    description {"Emergency Leave"}
    remark{"Not Available this date"}
    account_id{FactoryBot.create(:accounts).id}
  end
end