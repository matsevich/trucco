FactoryBot.define do
  factory :category do
    title { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
  end
end
