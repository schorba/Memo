class CategoriesController < ApplicationController

  before_action :find_categories
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

      if @category.save
        redirect_to new_picture_path, notice: 'Category was successfully created.'
      else
        flash[:error] = @category.errors.full_messages
        redirect_to new_picture_path
      end
  end


  private

  def find_categories
    @categories = Category.all
  end

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end

