module ProductsHelper
  def added_existing_prices_flash(quantity, name)
    flash[:success] = I18n.t('.existing_prices_success', quantity: quantity,
                                                         name: name,
                                                         item: i18n_item(quantity))
    redirect_to(products_path)
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

  private

  def i18n_item(quantity)
    I18n.locale == :en ? I18n.t('.item').pluralize(quantity) : I18n.t('.item')
  end
end
