class ExistingProductPriceUpdater
  def initialize(product, existing_product, product_price)
    @product = product
    @existing_product = existing_product
    @product_price = product_price
  end

  def update_quantity
    existing_product && existing_product_price && product_price_handler
  end

  def update_prices
    existing_product && add_price
  end

  private

  attr_reader :product, :existing_product, :product_price

  def existing_product_price
    ProductPriceHandler.new(existing_product, product_price).send(:existing_product_price)
  end

  def product_price_handler
    ProductPriceHandler.new(existing_product, product_price).call
  end

  def add_price
    existing_product.prices << product.prices.try(:first)
  end
end
