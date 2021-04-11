class ProductPriceHandler
  include ProductsHelper

  def initialize(product, flash, product_price, existing_product_price)
    @product = product
    @flash = flash
    @product_price = product_price
    @existing_product_price = existing_product_price
  end

  def call
    return unless price_update

    added_existing_prices_flash(
      product_price.quantity, product.name, product_price.buy_price.format, product_price.sell_price.format
    )
  end

  private

  attr_reader :product, :flash, :product_price, :existing_product_price

  def price_update
    existing_product_price.update(quantity: new_quantity) if product_price.valid?
  end

  def new_quantity
    existing_product_price.quantity + product_price.quantity
  end
end
