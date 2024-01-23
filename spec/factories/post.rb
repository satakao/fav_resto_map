FactoryBot.define do
  factory :post do
    store_name { Faker::Lorem.characters(number: 6) }
    description { Faker::Lorem.characters(number: 30) }
    
  end
end