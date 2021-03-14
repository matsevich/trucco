FactoryBot.define do
  factory :product do
    name { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
    price { Faker::Number.number(digits: [2, 3].sample) }
    category { Category.all.sample }
  end
end
