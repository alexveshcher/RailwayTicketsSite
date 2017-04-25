FactoryGirl.define do
  factory :user do
    email {Faker::Internet.safe_email}
    password {Faker::Internet.password(8)}
    role 'user'
  end

  factory :admin, class: User do
    email {Faker::Internet.safe_email}
    password {Faker::Internet.password(8)}
    role 'admin'
  end
end
