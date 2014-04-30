FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  factory :group do
    name "Group Name"
    gender "male"
    seeking_gender "female"
    association :location
    start_date 7.days.from_now
    end_date 12.days.from_now
  end

  factory :interest do
    name "interest"
    association :location
  end

  factory :location do
    city "Las Vegas"
    country "United States"
  end

  factory :relationship do
    association :liker
    association :liked
  end

  factory :user do
    name "Paul Jovanovic"
    email
    gender "male"
  end
end