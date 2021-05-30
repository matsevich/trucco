class PriceUpdater
  def initialize(product, price)
    @product = product
    @price = price
  end

  def call
    return unless identic_price

    identic_price.update(quantity: identic_price.quantity + price.quantity)
    product.prices.delete(price.id)
  end

  private

  attr_reader :product, :price

  def identic_price
    product.prices.by_existing_prices(
      price.buy_price_cents,
      price.sell_price_cents
    ).where.not(id: price.id).take
  end
end
