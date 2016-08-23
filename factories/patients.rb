FactoryGirl.define do
  factory :patient do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    ailment { ['broken bones', 'eye trouble', 'heart disease'].sample }
  end
end
