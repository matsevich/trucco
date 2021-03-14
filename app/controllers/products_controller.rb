class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    @pagy, @products = pagy(Product.order('created_at DESC'), items: 13)

    @product = Product.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render turbo_stream: turbo_stream.replace(@product, partial: 'products/form', locals: { product: @product })
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render turbo_stream: turbo_stream.replace(@product, partial: 'products/form', locals: { product: @product })
    end
  end

  def destroy
    @product.destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end

  def product
    @product = Product.find(params[:id])
  end
end
