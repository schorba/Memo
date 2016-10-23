class GamesController < ApplicationController

  before_action :get_categories
  before_action :get_game, only: [:show, :play, :open_picture]
  before_action :get_part, only: [:open_picture]
  before_action :find_games, only: [:index]

  def index
    if params[:game] && params[:game][:title]
      @games = @games.where(Game.arel_table[:title].matches("%#{params[:game][:title]}%"))
    end
  end

  def new
    @game = Game.new
    @part = @game.parts.new
  end


  def create
    @game = Game.new(
        rows: part_params[:quantity].to_i,
        columns: part_params[:quantity].to_i,
        description: game_params[:description].to_s,
        title: game_params[:title].to_s,
        category_ids: game_params[:category_ids],
        image: game_params[:image]
    )

    all_pictures_in_categories = @game.all_pictures_from_categories.count
    needed_pictures_count = (@game.rows * @game.columns) / 2

    if all_pictures_in_categories < needed_pictures_count
      flash[:error] = "No enough pictures in gallery. You need at least #{needed_pictures_count} pictures for this game."
      redirect_to new_game_path and return
    end


    if @game.save
      redirect_to games_path, notice: 'Game was successfully created.'
    else
      flash.now[:error] = (@game.errors.full_messages)
      render action: 'new'
    end
  end

  def update
  end

  def show
  end

  def play
    @parts = @game.parts.shuffle.each_slice(@game.rows).to_a

    @parts.each do |row| # activate parts for repeated play
      row.each do |p|
        p.update_attributes(is_active: true, is_opened: false)
      end
    end
  end

  def open_picture
    @opened_part = @game.find_opened_part

    unless @opened_part
      @part.open!
      @open_first_part = true
    else
      if @part.picture_id == @opened_part.picture_id
        @part.complete!
        @opened_part.complete!
        @open_second_part = true
      else
        @game.parts.not_completed.first.close!
      end
    end
    unless @game.parts.where(is_active: true).exists?
      @game.is_complete = true
      flash[:success] = "Game Over"
      redirect_to game_path(@game)
    end
  end


  private

  def game_params
    params.require(:game).permit(:title, :description, :image, category_ids: [])
  end

  def part_params
    params.require(:game).permit(:quantity, category_ids: []).merge(quantity: params[:part][:quantity])
  end

  def get_categories
    @categories = params[:game].present? && params[:game][:category_ids].present? ? params[:game][:category_ids].reject(&:blank?) : Category.all
  end

  def get_game
    @game = Game.find(params[:id])
  end

  def get_part
    @part = @game.parts.find(params[:part_id])
  end

  def find_games
    @games = !params[:category].present? ? Game.all : Category.find(params[:category]).games
  end

end
