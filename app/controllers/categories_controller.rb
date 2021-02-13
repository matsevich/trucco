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
      flash[:success] = "You have successfully created new '#{@category.title}' category"
      redirect_to categories_path
    else
      flash.now[:warning] = 'Invalid parameters'
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'You have successfully updated your category'
      redirect_to categories_path
    else
      flash.now[:warning] = 'Invalid parameters for editing'
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
    flash[:danger] = "You have deleted '#{@category.title}' category"
  end

  private

  def category_params
    params.require(:category).permit(:title, :description)
  end

  def category
    @category = Category.find(params[:id])
  end
end
