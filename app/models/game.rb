class Game < ApplicationRecord

  has_many :parts
  has_many :pictures, -> {uniq}, through: :parts

  has_many :categories_games
  has_many :categories, through: :categories_games


  validates :title, :image, :categories, :parts, presence: true


  has_attached_file :image,
                    styles: { medium: "200x150", thumb: "130x130>" },
                    default_url: "/images/:style/missing.png",
                    convert_options: {
                        medium: '-background white -gravity center -extent 200x150',
                        thumb: '-background white -gravity center -extent 135x130'
                    }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]



  before_validation :create_parts

  def create_parts
    pictures_count = (rows*columns) / 2
    pictures = all_pictures_from_categories.shuffle.first(pictures_count)

    pictures.each do |picture|
      2.times do
        self.parts.new(picture: picture)
      end
    end
  end


  def all_pictures_from_categories
    Picture.joins(:categories).where(categories: {id: category_ids}).uniq
  end

  def find_opened_part
    parts.find_by(is_opened: true)
  end

end
