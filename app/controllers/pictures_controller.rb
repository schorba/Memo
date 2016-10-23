class PicturesController < ApplicationController


  before_action :find_picture, only: [:show, :edit, :update, :destroy]
  before_action :find_categories
  before_action :find_pictures

  def index
  end

  def new
    @picture = Picture.new
    @categories = Category.all
  end

  def edit
  end

  def show
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to pictures_path, notice: 'Picture was successfully added.'
    else
      flash.now[:error] = @picture.errors.full_messages
      render action: 'new'
    end
  end


  private

  def find_picture
    @picture = Picture.find(params[:id])
  end

  def find_categories
    @categories = Category.all
  end

  def picture_params
    params.require(:picture).permit(:title, :description, :image, :category_ids => [])
  end

  def find_pictures
    @pictures = !params[:category].present? ? Picture.all :
        Category.find(params[:category]).picures
  end


end
