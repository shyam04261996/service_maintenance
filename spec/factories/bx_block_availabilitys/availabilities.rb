FactoryBot.define do
  factory :availability do
    start_time { "MyString" }
    end_time { "MyString" }
    unavailable_start_time { "MyString" }
    unavailable_end_time { "MyString" }
    availability_date { "MyString" }
    timeslots { "" }
    available_slots_count { 1 }
    status { "MyString" }
    remark { "MyString" }
    description { "MyString" }
  end
end
