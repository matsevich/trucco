FactoryBot.define do
  factory :price do
    buy_price { Faker::Number.number(digits: [2, 3].sample) }
    sell_price { buy_price + 50 }
    quantity { rand(1..8) }
  end
end
