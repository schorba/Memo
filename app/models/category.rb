class Category < ApplicationRecord
  has_many :categories_pictures
  has_many :pictures, through: :categories_pictures

  has_many :categories_games
  has_many :games, through: :categories_games

  validates :title, uniqueness: true, presence: true

  def to_label
    "#{title} (#{games.count})"
  end

end
