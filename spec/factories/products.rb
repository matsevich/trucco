FactoryBot.define do
  factory :product do
    name { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
    price_cents { Faker::Number.number(digits: 5) }
  end
end
