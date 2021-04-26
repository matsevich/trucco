FactoryBot.define do
  factory :category do
    title { Faker::Restaurant.unique.name }
    description { Faker::Restaurant.description }
  end
end
