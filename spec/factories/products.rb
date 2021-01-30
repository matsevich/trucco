FactoryBot.define do
  factory :product do
    name { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
  end
end
