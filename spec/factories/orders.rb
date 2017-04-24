FactoryGirl.define do
  factory :order do
    from_city_id { Faker::Number.number(10) }
    to_city_id { Faker::Number.number(10) }
    from_city_name { Faker::Lorem.word }
    to_city_name { Faker::Lorem.word }
    user_id { 1 }
  end
end
