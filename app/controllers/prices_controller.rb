class PricesController < ApplicationController
  include PricesHelper
  before_action :product, :price

  def edit; end

  def update
    if @price.update(price_params)
      PriceUpdater.new(@product, @price).call
      flash[:success] = t('.successfully_update', update_product: @product.name)
      redirect_to products_path
    else
      flash.now[:warning] = t('.invalid_edit_params')
      render :edit
    end
  end

  def sell_form; end

  def sell
    if ProductPriceSeller.new(price_params, @price).call
      @price.destroy if @price.quantity.zero?
      flash[:success] = i18n_for_sold(price_params)
      redirect_to products_path
    else
      flash.now[:warning] = invalid_sell_flash_text(price_params)
      render :sell_form
    end
  end

  def destroy
    @price.destroy

    @product.destroy if @product.prices.empty?

    redirect_to products_path
    flash[:danger] = t('.destroy_name', destroy_name: @product.name)
  end

  private

  def price_params
    params.require(:price).permit(
      :product_id, :buy_price, :sell_price, :quantity
    )
  end

  def product
    @product = Product.find(params[:product_id])
  end

  def price
    @price = @product.prices.find(params[:id])
  end
end
