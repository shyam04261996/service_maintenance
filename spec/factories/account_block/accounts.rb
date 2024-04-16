FactoryBot.define do
  factory :accounts, class: 'AccountBlock::Account' do
    first_name { "dummy" }
    last_name { "test" }
    email { Faker::Internet.email }
    role {"Employee"}
    password {"password"}
    full_phone_number {"+91-9876543210"}
  end
end
