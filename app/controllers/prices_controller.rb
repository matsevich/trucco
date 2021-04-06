class PricesController < ApplicationController
  before_action :product, :price

  def edit; end

  def update # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    if @price.update(price_params)
      if (identic = @product.prices.where(
        buy_price_cents: @price.buy_price_cents, sell_price_cents: @price.sell_price_cents
      ).where.not(id: @price.id).take)
        identic.update(quantity: identic.quantity + @price.quantity)
        @product.prices.delete(@price.id)
      end
      flash[:success] = t('.successfully_update', update_product: @product.name)
      redirect_to products_path
    else
      flash.now[:warning] = t('.invalid_edit_params')
      render :edit
    end
  end

  def destroy
    @price.destroy
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
