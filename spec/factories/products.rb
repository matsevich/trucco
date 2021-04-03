FactoryBot.define do
  factory :product do
    name { Faker::GreekPhilosophers.name }
    description { Faker::GreekPhilosophers.quote }
    category { Category.all.sample }

    transient do
      prices_count { 2 }
    end

    after(:create) do |product, evaluator|
      create_list(:price, evaluator.prices_count, product: product)
    end
  end
end
