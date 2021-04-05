class ProductsController < ApplicationController
  include ProductsHelper
  before_action :product, only: %i[edit update show destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
    @product.prices.build
  end

  def create
    @product = Product.new(product_params)
    product_price = @product.prices.try(:first)
    if (existing_product = Product.find_by(name: @product.name))
      if (existing_product_price = existing_product.prices.where(
        'buy_price_cents = ? AND sell_price_cents = ?', product_price.buy_price_cents, product_price.sell_price_cents
      ).try(:first))
        if existing_product_price.update(quantity: existing_product_price.quantity + product_price.quantity)
          added_existing_prices_flash(product_price.quantity, @product.name, product_price.buy_price.format, product_price.sell_price.format)
        else
          invalid_new_params_render
        end
      elsif existing_product.prices << @product.prices.try(:first)
        added_new_prices_flash(product_price.quantity, @product.name)
      else
        invalid_new_params_render
      end
    elsif @product.save
      added_new_product_flash(product_price.quantity, @product.name)
    else
      invalid_new_params_render
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:success] = t('.successfully_update')
      redirect_to products_path
    else
      flash.now[:warning] = t('.invalid_edit_params')
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
    flash[:danger] = t('.destroy_product', destroy_product: @product.name)
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :category_id, prices_attributes: %i[id product_id buy_price sell_price quantity]
    )
  end

  def product
    @product = Product.find(params[:id])
  end
end
