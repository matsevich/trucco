class Price < ApplicationRecord
  belongs_to :product

  monetize :buy_price_cents, :sell_price_cents, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 300_000
  }
end
