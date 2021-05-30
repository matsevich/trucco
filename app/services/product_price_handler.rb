class ProductPriceHandler
  def initialize(existing_product, product_price)
    @existing_product = existing_product
    @product_price = product_price
  end

  def call
    price_update if product_price.valid?
  end

  private

  attr_reader :existing_product, :product_price

  def price_update
    existing_product_price.update(quantity: new_quantity)
  end

  def new_quantity
    existing_product_price.quantity + product_price.quantity
  end

  def existing_product_price
    existing_product.prices.by_existing_prices(
      product_price.buy_price_cents,
      product_price.sell_price_cents
    ).try(:first)
  end
end
