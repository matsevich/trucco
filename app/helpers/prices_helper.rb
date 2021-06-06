module PricesHelper
  def invalid_params(price_params)
    price_params[:quantity].to_i > price.quantity || price_params[:quantity].to_i <= 0
  end

  def invalid_sell_flash_text(price_params)
    if price_params[:quantity].to_i < 1
      t('.quantity_must_be_higher')
    else
      t('.invalid_for_sell_params')
    end
  end

  def i18n_for_sold(price_params)
    t('.successfully_sold', quantity: price_params[:quantity], product: product.name)
  end
end
