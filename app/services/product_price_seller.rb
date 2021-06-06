class ProductPriceSeller
  def initialize(price_params, price)
    @price_params = price_params
    @price = price
  end

  def call
    return if price_params[:quantity].to_i < 1

    if new_sell_price.eql?(old_sell_price)
      @price.update(quantity: new_price_quantity)
    else
      @price.update(sell_price: price_params[:sell_price], quantity: new_price_quantity)
    end
  end

  private

  attr_reader :price_params, :price

  def new_sell_price
    price_params[:sell_price].to_f
  end

  def old_sell_price
    @price.sell_price.format.to_f
  end

  def new_price_quantity
    @price.quantity - price_params[:quantity].to_i
  end
end
