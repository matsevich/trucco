class ProductsController < ApplicationController
  before_action :product, only: %i[edit update destroy]

  def index
    @products = Product.all
    #Product.joins(:prices).where.not('prices.quantity = ?', 0).distinct
  end

  def show; end

  def new
    @product = Product.new
    @product.prices.build
  end

  def create
    @product = Product.new(product_params)
    product_price = @product.prices.try(:first)
    new_buy_price = product_price.buy_price
    new_sell_price = product_price.sell_price
    if (existing_product = Product.find_by(name: @product.name))
      new_buy_price_cents = product_price.buy_price_cents
      new_sell_price_cents = product_price.sell_price_cents
      if (existing_product_price = existing_product.prices.where(
        'buy_price_cents = ? AND sell_price_cents = ?', new_buy_price_cents, new_sell_price_cents
      ).try(:first))
        if existing_product_price.update(quantity: existing_product_price.quantity + product_price.quantity)
          flash[:success] = "You add #{product_price.quantity} item(s) of #{@product.name}, with existing #{new_buy_price.format} - 'buy_price' and #{new_sell_price.format} - 'sell_price'" # t('.create_title', create_title: @product.name)
          redirect_to products_path
        else
          flash.now[:warning] = t('.invalid_params')
          render :new
        end
      elsif existing_product.prices << @product.prices.try(:first)
        flash[:success] = "You add #{product_price.quantity} item(s) of #{@product.name}, with new prices" # t('.create_title', create_title: @product.name)
        redirect_to products_path
      else
        flash.now[:warning] = t('.invalid_params')
        render :new
      end
    elsif @product.save
      flash[:success] = "You have add #{product_price.quantity} item(s) of new #{@product.name}" # t('.create_title', create_title: @product.name)
      redirect_to products_path
    else
      flash.now[:warning] = t('.invalid_params')
      render :new
    end
  end

  def edit; end

  def update
    @product = @product.prices(params[:id])
    if @product.update(product_params)
      flash[:success] = t('.successfully_update')
      redirect_to products_path
    else
      flash.now[:warning] = t('.invalid_edit_params')
      render :edit
    end
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
