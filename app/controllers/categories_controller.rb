class CategoriesController < ApplicationController
  before_action :category, only: %i[edit update destroy]

  def index
    @categories = Category.order(:title)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t('.create_title', create_title: @category.title)
      redirect_to categories_path
    else
      flash.now[:warning] = t('.invalid_params')
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = t('.successfully_update')
      redirect_to categories_path
    else
      flash.now[:warning] = t('.invalid_edit_params')
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
    flash[:danger] = t('.destroy_title', destroy_title: @category.title)
  end

  private

  def category_params
    params.require(:category).permit(:title, :description)
  end

  def category
    @category = Category.find(params[:id])
  end
end
