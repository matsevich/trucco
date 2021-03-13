FactoryBot.define do
  factory :product do
    name { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
    price { Faker::Number.number(digits: 5) }
    category
  end
end
