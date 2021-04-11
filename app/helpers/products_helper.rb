module ProductsHelper
  def added_existing_prices_flash(quantity, name, buy_price, sell_price)
    flash[:success] = I18n.t('.existing_prices_success', quantity: quantity,
                                                         name: name,
                                                         item: i18n_item(quantity),
                                                         buy_price: buy_price,
                                                         sell_price: sell_price)
  end

  def invalid_new_params
    flash.now[:warning] = I18n.t('.invalid_new_params')
    render :new
  end

  def added_new_prices_flash(quantity, name)
    flash[:success] = I18n.t('.new_prices_success',
                             quantity: quantity,
                             item: i18n_item(quantity),
                             name: name)
    redirect_to products_path
  end

  def added_new_product_flash(quantity, name)
    flash[:success] = I18n.t('.new_product_success', quantity: quantity,
                                                     item: i18n_item(quantity),
                                                     name: name)
    redirect_to products_path
  end

  def behavior_existing_product_price(product, existing_product, product_price)
    if existing_product_price(existing_product, product_price)
      product_price_handler(product, existing_product, product_price) ? redirect_to(products_path) : invalid_new_params
    elsif existing_product.prices << product.prices.try(:first)
      added_new_prices_flash(product_price.quantity, product.name)
    else
      invalid_new_params
    end
  end

  private

  def product_price_handler(product, existing_product, product_price)
    ProductPriceHandler.new(
      product, flash, product_price, existing_product_price(existing_product, product_price)
    ).call
  end

  def existing_product_price(existing_product, product_price)
    existing_product.prices.by_existing_prices(
      product_price.buy_price_cents,
      product_price.sell_price_cents
    ).try(:first)
  end

  def i18n_item(quantity)
    I18n.locale == :en ? I18n.t('.item').pluralize(quantity) : I18n.t('.item')
  end
end
