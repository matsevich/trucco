class PriceUpdater
  def initialize(product, price)
    @product = product
    @price = price
  end

  def call
    return unless identic_price

    identic.update(quantity: identic.quantity + price.quantity)
    product.prices.delete(price.id)
  end

  private

  attr_reader :product, :price, :identic

  def identic_price
    @identic = product.prices.where(
      buy_price_cents: price.buy_price_cents,
      sell_price_cents: price.sell_price_cents
    ).where.not(id: price.id).take
  end
end
