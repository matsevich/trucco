class Price < ApplicationRecord
  belongs_to :product

  validates :buy_price_cents, :sell_price_cents, numericality: { only_integer: true, greater_than: 0 }

  validates :quantity, presence: true, numericality: { only_integer: true },
                       inclusion: { in: :selling_quantiti, message: I18n.t('prices.quantity_inclusion') }

  scope :by_existing_prices, lambda { |buy_price, sell_price|
    where('buy_price_cents = ? AND sell_price_cents = ?', buy_price, sell_price)
  }

  monetize :buy_price_cents, :sell_price_cents, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 300_000
  }

  def selling_quantiti
    (0..quantity)
  end
end
