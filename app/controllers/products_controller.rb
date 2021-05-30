class ProductsController < ApplicationController
  include ProductsHelper
  before_action :product, only: %i[edit update show destroy]
  before_action :new_product, :existing_product, :new_product_price, only: :create

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
    @product.prices.build
  end

  def create
    case
    when ExistingProductPriceUpdater.new(@product, @existing_product, @product_price).update_quantity
      added_existing_prices_flash(@product_price.quantity, @existing_product.name)
    when ExistingProductPriceUpdater.new(@product, @existing_product, @product_price).update_prices
      added_new_prices_flash(@product_price.quantity, @product.name)
    when !@existing_product && @product.save
      added_new_product_flash(@product_price.quantity, @product.name)
    else
      invalid_new_params
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

  def new_product
    @product = Product.new(product_params)
  end

  def existing_product
    @existing_product = Product.find_by(name: @product.name)
  end

  def new_product_price
    @product_price = @product.prices.try(:first)
  end
end
