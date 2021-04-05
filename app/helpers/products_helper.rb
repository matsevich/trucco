module ProductsHelper
  def added_existing_prices_flash(quantity, name, buy_price, sell_price)
    flash[:success] = t('.existing_prices_success', quantity: quantity,
                                                    name: name,
                                                    item: t('.item').pluralize(quantity),
                                                    buy_price: buy_price,
                                                    sell_price: sell_price)
    redirect_to products_path
  end

  def invalid_new_params_render
    flash.now[:warning] = t('.invalid_new_params')
    render :new
  end

  def added_new_prices_flash(quantity, name)
    flash[:success] = t('.new_prices_success', quantity: quantity, item: t('.item').pluralize(quantity), name: name)
    redirect_to products_path
  end

  def added_new_product_flash(quantity, name)
    flash[:success] = t('.new_product_success', quantity: quantity, item: t('.item').pluralize(quantity), name: name)
    redirect_to products_path
  end
end
