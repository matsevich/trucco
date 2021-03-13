class Product < ApplicationRecord
  belongs_to :category

  monetize :price_cents, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 300_000
  }
  validates :name, :price_cents, presence: true

  after_create_commit  -> { broadcast_prepend_to 'products' }
  after_update_commit  -> { broadcast_replace_to 'products' }
  after_destroy_commit -> { broadcast_remove_to 'products' }
end
