class Product < ApplicationRecord
  monetize :price_cents, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 300_000
  }
  validates :name, :description, :price_cents, presence: true
end
